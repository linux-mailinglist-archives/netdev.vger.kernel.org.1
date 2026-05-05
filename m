Return-Path: <netdev+bounces-284600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOpaKbp6+mlePQMAu9opvQ
	(envelope-from <netdev+bounces-284600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:18:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6684D4A43
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BB583046EBE
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 23:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6E73382E5;
	Tue,  5 May 2026 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="kX/vZv1+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364073090C6
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778023055; cv=pass; b=jX4EhUKSPrFQS8wCGjGrcM09NL8HfKkkVErb9NQdF50PfSnKPfaARtVNa5SZAImmLPZE6o/ssKxKfILQaJygkLdRBbFLZevAofoh4T6eCDHlezcRaMHolEQlIT70aG13/mDIGQ72DguESorhQJPrPtG6w7QmvRxXsnY7QySBQN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778023055; c=relaxed/simple;
	bh=ef/MzUyf7VedQkBFAXuEDwBAG1wJTQuMidX6Kyu4lhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJEPwHb9Kr3c4kC58/QHt450iFoS167fFuW4DMXnnWPzZNGmR+yu7k99gJaz0wSFMjndYI/skHSKbRLwMfCqbSzrAjpjk9k7T12JfME7RayGaN8s68qfbY9K6hoeTweL5JzJbUaLzJ6cHmNZKEByha/LKc+XODAXRL5glA+EOqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=kX/vZv1+; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a884815606so990722e87.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 16:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778023050; cv=none;
        d=google.com; s=arc-20240605;
        b=WtHx4qa72wTHAas3u3AHgu6lG/n+Bt/XWAlnMiEOtWemhyQjFBTeQdmY3kSnqgOddq
         GYDKjEh+yNyDfSoFEQURLctId+wLfYqS3i+zeoMKqxQw8x16N0LS2loSnd+80aZHG/bm
         UMPAy3B/WEAeEG8qFt1mJrTDdQ0zbgjwhr8DcWNCws5bXwZuhTyLoG+mY+7d5geBJY+Y
         6PsqMnIOmhSmbCUjJzgMY9V36i4RzNomyYEDMZyt0yNgQSdjBOkeJczi3jr7lvzna2iX
         7uRIRRqQmFcK/rj1nCDz8a1NKUTA106+yjnDDEXfMoICTY8yzlP6ZBToQ/xOvNXnAUig
         3lww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sbkL0dSedhIlHAkm5zLSxKnvc/+dmcs/ZtFP69v5vVk=;
        fh=LA7+tDDu5G/gEW8cX49kj42pviJIK/VlZCZZaCFIeUg=;
        b=lDz3WUi4MasbbetW7k/vEf9jWUHoBo1XwfmGBW/FxU5w/YeI3uilJNlkt4UySahGcg
         B/0xbwfl6DVqxz2x6fEQtXncyYO5rhaktAoW8VRr0kT61Ifya0EadSiTq0xmT6HUv0tP
         U9JF9UO8dJ2aPp27qFzzPKTD4hGuBmcC6+pM5DDb5FivFWkVF+2sWoJlsRZd8RAiJ8oT
         3chRuVG8o3VRTqHT0D2OmEy0N8PkqPi976Aozon+sYRMDEKMqgZh4YPaIslbNYIwU7IV
         SZckjvw/FWF1NE45eSvMwKlYsJk5M3xl6kRD41w7xS8ITImOW9Ud1qKbqy4WCEXzVh8+
         NQXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1778023050; x=1778627850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbkL0dSedhIlHAkm5zLSxKnvc/+dmcs/ZtFP69v5vVk=;
        b=kX/vZv1++mRW0Jk8YjSESDBdJ1f9fMdyxRQh6ebv3Vlc46SZ7IUM5Pvzof3tVKwoNd
         9Q4jXULncEcCUkuU0B8Efc4N4fdsJqYPSPJASOAA+thu84XKOFJxoFT2vUflvZemvpkX
         NGXpD6i/I1lXVKP8dSXxFIupw3CJyezzKs9HGcAzRNfUgW6ys/SVJ5y0E7I3UKJsBn6N
         Y4vECBGoxARmflGfwLdNZfrLAqUs7ZQ3Kmv0RYX1ke9ld9GSNgkyijceU8ZO0lzH7Zcj
         dPwTOjqJEnKWGire/4GpTg7fMtxYsc+aEZU1zOmPKtXP2IdNkLjpDHP8HKk/VmYsHqrQ
         v2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778023050; x=1778627850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sbkL0dSedhIlHAkm5zLSxKnvc/+dmcs/ZtFP69v5vVk=;
        b=MPW5fDvwk6bS0iTVwJ9zRy22LPqio+X3u+fTBPNt5F3L1N8GpZoQa2ZoZBel1H32r0
         hQQ9u6c6cLa0kNCB5lpIOiaC+UVv6ol+8lw7M3KmQGh4dG8Kfej8XfQCqlmPLLuWQbH+
         bIibxXK5djl4oZxggQnXl2qpvlJWdNWysNzI0r6rKhM8xUl2uSLZ3Uh8X8oN15EhyrDt
         UKL71QmnlIuILCIqrhFjJRsDesyl/9/vggnVyPdWYnQfN86hcPQHr9ZEPUJ1kST8gnOy
         SoiF+9g9s7HyfD5uTasWdQwdCWTVYK84VNGqp9iOXHJxRTwxks+EOc1vDuJ/1XDofhCZ
         QUyw==
X-Forwarded-Encrypted: i=1; AFNElJ+jbyk4fLMCLRn9ifAKKARLZKPxVsJZZfw9plZx3JVDddAGkQZC5P6Yd7EKiS/I82ENs2L96yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsWYxgffwXKC+HV/4qFKZgiGx8B5kEOsASbc5Qs/pneqq1v0u
	KUspQPsCGXXX1Fty77ZT1OI+yRigPrxdqUUAkpkaMAV55oAkkiUamXZCd4MMjP+gdRf+Rt87dz+
	OkyVIxNdVjiMVCdiUbeVnXbSOmbVZ+KQhbtcdZbMY
X-Gm-Gg: AeBDietoSRwMnPFxbhnvntDW44z5Sv8P81SMbIwyiOYuPFSkQcnF+6ZbID8V+zQm6l0
	zFf6OYHhaUvqHu9lDiKw3fW0UQuVnNMilbrl18U/yqXqJi/I88K1BIR7SPbWyVPltubIXia4R58
	ESWBTbCvfhVHYuJtoBEJDa2M9HQIKpCLKDgOMH2F056+oeSFqhWYyDdkCqTfSDAJ0nZOod2Ks7m
	4P4afRbPuodMrloIcte4wDrkiSAw1ElhV2dQ+8WtkW2salld4V4yfpplLxubtD3BtRoS6jovKxZ
	9I/A5mhzHRUvt5+FQDagu7q58yZR9agwS184jXGs1znggkjmPw==
X-Received: by 2002:a05:6512:3e1e:b0:5a8:6383:eb1d with SMTP id
 2adb3069b0e04-5a887a9a1f8mr255421e87.0.1778023050325; Tue, 05 May 2026
 16:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430011544.31823-1-ebiggers@kernel.org>
In-Reply-To: <20260430011544.31823-1-ebiggers@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 5 May 2026 16:17:18 -0700
X-Gm-Features: AVHnY4LKSVkLgCr9Vwa8gK1KVDGqtIFkDawKs1AD3wzCIeuai4aVYTh3ZhWd8CA
Message-ID: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-doc@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0A6684D4A43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284600-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[copy.fail:url,chronox.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,amacapital-net.20251104.gappssmtp.com:dkim]

> On Apr 29, 2026, at 6:19=E2=80=AFPM, Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> =EF=BB=BFAF_ALG is almost completely unnecessary, and it exposes a massiv=
e attack
> surface that hasn't been standing up to modern vulnerability discovery
> tools.  The latest one even has its own website, providing a small
> Python script that reliably roots most Linux distros: https://copy.fail/

How about adding a configuration option, defaulted on, that requires
capable(CAP_SYS_ADMIN) to create the socket (and maybe also to bind /
connect it).  And a sysctl to allow the administrator to override this
in the unlikely event that it=E2=80=99s needed.

IIRC cryptsetup used to and maybe even still does require these
sockets sometimes and this would let it keep working.  And there's all
the FIPS stuff downthread.


>
> This isn't sustainable, especially as LLMs have accelerated the rate the
> vulnerabilities are coming in.  The effort that is being put into this
> thing is vastly disproportional to the few programs that actually use
> it, and those programs would be better served by userspace code anyway.
>
> These issues have been noted in many mailing list discussions already.
> But until now they haven't been reflected in the documentation or
> kconfig menu itself, and the vulnerabilities are still coming in.
>
> Let's go ahead and document the deprecation.
>
> This isn't intended to change anything overnight.  After all, most Linux
> distros won't be able to disable the kconfig options quite yet, mainly
> because of iwd.  But this should create a bit more impetus for these
> userspace programs to be fixed, and the documentation update should also
> help prevent more users from appearing.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>
> This patch is targeting crypto/master
>
> Documentation/crypto/userspace-if.rst | 82 ++++++++++++++++++++-------
> crypto/Kconfig                        | 69 ++++++++++++++++------
> 2 files changed, 113 insertions(+), 38 deletions(-)
>
> diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto=
/userspace-if.rst
> index 021759198fe7..c39f5c79a5b7 100644
> --- a/Documentation/crypto/userspace-if.rst
> +++ b/Documentation/crypto/userspace-if.rst
> @@ -2,30 +2,72 @@ User Space Interface
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Introduction
> ------------
>
> -The concepts of the kernel crypto API visible to kernel space is fully
> -applicable to the user space interface as well. Therefore, the kernel
> -crypto API high level discussion for the in-kernel use cases applies
> -here as well.
> -
> -The major difference, however, is that user space can only act as a
> -consumer and never as a provider of a transformation or cipher
> -algorithm.
> -
> -The following covers the user space interface exported by the kernel
> -crypto API. A working example of this description is libkcapi that can
> -be obtained from [1]. That library can be used by user space
> -applications that require cryptographic services from the kernel.
> -
> -Some details of the in-kernel kernel crypto API aspects do not apply to
> -user space, however. This includes the difference between synchronous
> -and asynchronous invocations. The user space API call is fully
> -synchronous.
> -
> -[1] https://www.chronox.de/libkcapi/index.html
> +AF_ALG provides unprivileged userspace programs access to arbitrary hash=
,
> +symmetric cipher, AEAD, and RNG algorithms that are implemented in kerne=
l-mode
> +code.
> +
> +AF_ALG is insecure and is deprecated. Originally added to the kernel in =
2010,
> +most kernel developers now consider it to be a mistake.
> +
> +AF_ALG continues to be supported only for backwards compatibility. On sy=
stems
> +where no programs using AF_ALG remain, the support for it should be disa=
bled by
> +disabling ``CONFIG_CRYPTO_USER_API_*``.
> +
> +Deprecation
> +-----------
> +
> +AF_ALG was originally intended to provide userspace programs access to c=
rypto
> +accelerators that they wouldn't otherwise have access to.
> +
> +However, that capability turned out to not be useful on very many system=
s. More
> +significantly, the actual implementation exposes a vastly greater amount=
 of
> +functionality than that. It actually provides access to all software alg=
orithms.
> +
> +This includes arbitrary compositions of different algorithms created via=
 a
> +complex template system, as well as algorithms that only make sense as i=
nternal
> +implementation details of other algorithms. It also includes full zero-c=
opy
> +support, which is difficult for the kernel to implement securely.
> +
> +Ultimately, these algorithms are just math computations. They use the sa=
me
> +instructions that userspace programs already have access to, just access=
ed in a
> +much more convoluted and less efficient way.
> +
> +Indeed, userspace code is nearly always what is being used anyway. These=
 same
> +algorithms are widely implemented in userspace crypto libraries.
> +
> +Meanwhile, AF_ALG hasn't been withstanding modern vulnerability discover=
y tools
> +such as syzbot and large language models. It receives a steady stream of=
 CVEs.
> +Some of the examples include:
> +
> +- CVE-2026-31677
> +- CVE-2026-31431 (https://copy.fail)
> +- CVE-2025-38079
> +- CVE-2025-37808
> +- CVE-2024-26824
> +- CVE-2022-48781
> +- CVE-2019-8912
> +- CVE-2018-14619
> +- CVE-2017-18075
> +- CVE-2017-17806
> +- CVE-2017-17805
> +- CVE-2016-10147
> +- CVE-2015-8970
> +- CVE-2015-3331
> +- CVE-2014-9644
> +- CVE-2013-7421
> +- CVE-2011-4081
> +
> +It is recommended that, whenever possible, userspace programs be migrate=
d to
> +userspace crypto code (which again, is what is normally used anyway) and
> +``CONFIG_CRYPTO_USER_API_*`` be disabled.  On systems that use SELinux, =
SELinux
> +can also be used to restrict the use of AF_ALG to trusted programs.
> +
> +The remainder of this documentation provides the historical documentatio=
n for
> +the deprecated AF_ALG interface.
>
> User Space API General Remarks
> ------------------------------
>
> The kernel crypto API is accessible from user space. Currently, the
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 103d1f58cb7c..6cd1c478d4be 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1278,48 +1278,72 @@ config CRYPTO_DF80090A
>    tristate
>    select CRYPTO_AES
>    select CRYPTO_CTR
>
> endmenu
> -menu "Userspace interface"
> +menu "Userspace interface (deprecated)"
>
> config CRYPTO_USER_API
>    tristate
>
> config CRYPTO_USER_API_HASH
> -    tristate "Hash algorithms"
> +    tristate "Hash algorithms (deprecated)"
>    depends on NET
>    select CRYPTO_HASH
>    select CRYPTO_USER_API
>    help
> -      Enable the userspace interface for hash algorithms.
> +      Enable the AF_ALG userspace interface for hash algorithms.  This
> +      provides unprivileged userspace programs access to arbitrary hash
> +      algorithms implemented in the kernel's privileged execution contex=
t.
>
> -      See Documentation/crypto/userspace-if.rst and
> -      https://www.chronox.de/libkcapi/html/index.html
> +      This interface is deprecated and is supported only for backwards
> +      compatibility.  It regularly has vulnerabilities, and the capabili=
ties
> +      it provides are redundant with userspace crypto libraries.
> +
> +      Enable this only if needed for support for a program that hasn't y=
et
> +      been converted to userspace crypto, for example iwd.
> +
> +      See also Documentation/crypto/userspace-if.rst
>
> config CRYPTO_USER_API_SKCIPHER
> -    tristate "Symmetric key cipher algorithms"
> +    tristate "Symmetric key cipher algorithms (deprecated)"
>    depends on NET
>    select CRYPTO_SKCIPHER
>    select CRYPTO_USER_API
>    help
> -      Enable the userspace interface for symmetric key cipher algorithms=
.
> +      Enable the AF_ALG userspace interface for symmetric key algorithms=
.
> +      This provides unprivileged userspace programs access to arbitrary
> +      symmetric key algorithms implemented in the kernel's privileged
> +      execution context.
> +
> +      This interface is deprecated and is supported only for backwards
> +      compatibility.  It regularly has vulnerabilities, and the capabili=
ties
> +      it provides are redundant with userspace crypto libraries.
> +
> +      Enable this only if needed for support for a program that hasn't y=
et
> +      been converted to userspace crypto, for example iwd, or cryptsetup
> +      with certain algorithms.
>
> -      See Documentation/crypto/userspace-if.rst and
> -      https://www.chronox.de/libkcapi/html/index.html
> +      See also Documentation/crypto/userspace-if.rst
>
> config CRYPTO_USER_API_RNG
> -    tristate "RNG (random number generator) algorithms"
> +    tristate "Random number generation algorithms (deprecated)"
>    depends on NET
>    select CRYPTO_RNG
>    select CRYPTO_USER_API
>    help
> -      Enable the userspace interface for RNG (random number generator)
> -      algorithms.
> +      Enable the AF_ALG userspace interface for random number generation
> +      (RNG) algorithms.  This provides unprivileged userspace programs
> +      access to arbitrary RNG algorithms implemented in the kernel's
> +      privileged execution context.
>
> -      See Documentation/crypto/userspace-if.rst and
> -      https://www.chronox.de/libkcapi/html/index.html
> +      This interface is deprecated and is supported only for backwards
> +      compatibility.  It regularly has vulnerabilities, and the capabili=
ties
> +      it provides are redundant with userspace crypto libraries as well =
as
> +      the normal kernel RNG (e.g., /dev/urandom and getrandom(2)).
> +
> +      See also Documentation/crypto/userspace-if.rst
>
> config CRYPTO_USER_API_RNG_CAVP
>    bool "Enable CAVP testing of DRBG"
>    depends on CRYPTO_USER_API_RNG && CRYPTO_DRBG
>    help
> @@ -1330,20 +1354,29 @@ config CRYPTO_USER_API_RNG_CAVP
>
>      This should only be enabled for CAVP testing. You should say
>      no unless you know what this is.
>
> config CRYPTO_USER_API_AEAD
> -    tristate "AEAD cipher algorithms"
> +    tristate "AEAD cipher algorithms (deprecated)"
>    depends on NET
>    select CRYPTO_AEAD
>    select CRYPTO_SKCIPHER
>    select CRYPTO_USER_API
>    help
> -      Enable the userspace interface for AEAD cipher algorithms.
> +      Enable the AF_ALG userspace interface for authenticated encryption
> +      with associated data (AEAD) algorithms.  This provides unprivilege=
d
> +      userspace programs access to arbitrary AEAD algorithms implemented=
 in
> +      the kernel's privileged execution context.
> +
> +      This interface is deprecated and is supported only for backwards
> +      compatibility.  It regularly has vulnerabilities, and the capabili=
ties
> +      it provides are redundant with userspace crypto libraries.
> +
> +      Enable this only if needed for support for a program that hasn't y=
et
> +      been converted to userspace crypto, for example iwd.
>
> -      See Documentation/crypto/userspace-if.rst and
> -      https://www.chronox.de/libkcapi/html/index.html
> +      See also Documentation/crypto/userspace-if.rst
>
> config CRYPTO_USER_API_ENABLE_OBSOLETE
>    bool "Obsolete cryptographic algorithms"
>    depends on CRYPTO_USER_API
>    default y
>
> base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
> --
> 2.54.0
>
>

