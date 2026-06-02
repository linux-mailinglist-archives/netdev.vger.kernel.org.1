Return-Path: <netdev+bounces-293965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL5WBSBAHmraiAkAu9opvQ
	(envelope-from <netdev+bounces-293965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:29:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674216273B6
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAEFD3052B60
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8796335562;
	Tue,  2 Jun 2026 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hy41QQgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24F26D4CA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367158; cv=pass; b=BwUlrDdFoIAZ1l+oraH4mAv23wlz5N5huA++JEe4M1KozM93MVHVPfFaLtdFBxLlW16JPhgAMfTshnqn4bychRF3/v4bo/vz3VRMQdhQorsqXMXXdRlkKHD1zi53eoIJelb+V/zj0yHxqCTucZBRKjIgZyY0fOyZDvM16OhrXV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367158; c=relaxed/simple;
	bh=SHfdS2VEWAub4TyYyXoE7ajtUpi3U0jl7n1AyOddBXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIOSvqRwNdV33CWG6mkyJBPG7TcWEcWO95PX1dVzjk3hk99c6UWKQKgycuZPggddD4kSKUnEDUbeGwKhH4+KUiIFAB3axm6O1WVcNiwlIE2t9+ennyKd5Wyl6GMFdJyfSwspCwexnzGKEyPnE3m/Bf79tfd7I+hkN1yLU3XweRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hy41QQgt; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b8d414666so2964828a91.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 19:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780367157; cv=none;
        d=google.com; s=arc-20240605;
        b=lGrFOJAXm0xhNxgfDRv2tRFYjuFA5EDvts/tQZGGyPN2UBRvHNL2OGeOmTGuo9CLQm
         vNqVD2TYMXkknMyOa88GgG13bmwRwbsPeCCuZ3TRFSDvNv+fVsseyJ5Q7Evx7GQf7F/X
         Z55j9XKNXu48IJAZYQJJktLQ35HnqfdfgpWNII7NcmX6Y0czL19hRGJqzBz2igZjA50r
         yi+vNek16OhKaxUxI25ZFYwuImGiMSlGK3erQGhlckYFqQ2MMIuPFnfLDGwfI4pXB+Q3
         tJaOmYyxml0Da7/qpeOHlg6whU8y77LbTHvv3HJ+2aAK76ATImXUlmi0ucEJhTREjzHR
         LRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S0Z1nJtgWy+a38xLnHO1hVIRfg2cTqLRzxBCr4E8BSQ=;
        fh=1QLDgCDfl5emVGPf9nG4p9NLXE8sUFIjaO6BzmCxAVE=;
        b=lqp82EXkXRvL79L59hCCKpKtrb4SBUGZGaI4hu1YOdV0snEKNyM50gpy19msbarHej
         wrS+fNssbGTDeH7WmqtnV6H4/xcVQLI6b+N/mTOIMOXr7UDXL8FtXmYsgNK8DewgMvZv
         s3JU/l8br7Ii7j7vl9UECqjmpuH1QCPlPrG9z1wnW+C27YpMdx+0tjbkEAu3opUQdAjg
         LDJvWVpCIuqJRCtZYpyaLkEOCD4Ap3zwGw+zgZu4P6412g9Hx3X0RDG8VXmseEiQ3aGw
         8a6QkppGlfaHzxykcdGoi/ENQK0IwQnUjYpDESXStFkfy1QTLW5okRoLZZslqSJkhyTi
         DWDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780367157; x=1780971957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0Z1nJtgWy+a38xLnHO1hVIRfg2cTqLRzxBCr4E8BSQ=;
        b=Hy41QQgtm4LHC0BkWBuC7zmrfKiGZVGcNEZcTj1ohBYWlMZ8rIj95OlPqefxtiB121
         v/UXCmDPUicVucAGuAU/8Acy09ylN2cgMBQQsL6sJL5LVjMmYINJOuzVgO7Xu+99dXK1
         JyWqanz7UKuM7QeMrIAdRQqFzTxhIelWOr2OskNSVN7Ka+FwG+n+HwRbrOQT1MAly+RE
         MeAOCWDPZ/IFFvOlF6dzVbJGbtqw0KReP5KeXGxU6SDdF0SE2M9p561vtP8upPY1XUhH
         aNo22xa1SVLB9Q2Of7FGEaKl7hSaYV5D1OUhM6sm/8P07lY8LZ2lIbtnEK0jxtLejOhv
         YPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780367157; x=1780971957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0Z1nJtgWy+a38xLnHO1hVIRfg2cTqLRzxBCr4E8BSQ=;
        b=JHjCnm0IKQG9Qn44X5it5IoN1HQd5eQWdOYsOTQZgWP+NGVFAbLdDnIbjx6CH3CufH
         2xCFYUR9Hr+8f+YNgpZ26FB4xDv1U3U427q/GBxxgphVtNA3gYsCkCSKoHxqoWiOS6le
         /5Clrx/Im1FgVkYzPd0hIIkS8vzdYyzqywDGAPe0a4AeZt8eE8p6GMo7knysokMkJFY0
         EaY5QrpRb+O/DMZm1XJGS5WpQsUcV2yMrkl9EiguqeiuqICw7MEfMflxmd4FuWWNf/EC
         n6UTu28T7gfG5cQ+/TDCXri6MljDGDkY4noX2dco7U2bja04q2LlYIpaOigqM0CXs8Fg
         8GHA==
X-Forwarded-Encrypted: i=1; AFNElJ/8TjJZ+IeoGeP8hZ1G5+aYEnmIi/7eRl+9dz5WGJJ0zqWiNaF9tSonc7/rBixrZVMFLdVXa50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxugJoHjN+p1mFanKNHuJ1MoACNRN1I48zxH0YHlclFTAREO85J
	OeOJrziImS1E1crEbbtzPWxlLNtYgMj9Z/A8Ym0QuTYMWXbAZ6NBwQcl2vOT0fqb/2vDb4s0nhZ
	ICA5MXqBfCC7LJ1/ncM6umB5r2uD91GcZmsxsM8f7
X-Gm-Gg: Acq92OHx/wo1UA/bBHzlxG/5BcisJ1IcKwp+9HxPw4YFJIteV7e2ZqyMVl4K8QDg9Fi
	+Ym9pxw9Su9i/I2EKnb32jTP/s1xi2kcqY1U2OYi6BxWO7pSMzsnX/3uwoSnKD0WbVkXActtlHc
	6bKp0VqAwWJ4SwtJQNEe1IYnQ97Emvv9bqxVGUQ6G9ihkvD2bxs6/pe/GgFwOb9ziois6N1Nl/H
	30v2vWBh+SjwuCOLS+nf4K2NUKtgc693ualSql7ucNkEjfMCsc+4/LS32SAK95UiauQTVbFnGaP
	YiyOGWUUfHsZVj9JpA==
X-Received: by 2002:a17:90b:190c:b0:36d:689a:cb27 with SMTP id
 98e67ed59e1d1-36d689ad524mr7937838a91.24.1780367157009; Mon, 01 Jun 2026
 19:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528015913.190970-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260528015913.190970-1-zhaochenguang@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 22:25:44 -0400
X-Gm-Features: AVHnY4LEslACqmhRDmjIDxORWlDmheu5ptft12NvTVjJPoPavYK0NILJ_kRg5ow
Message-ID: <CAHC9VhThD1mhAZDwkirTOnYxycSAghW4RxyF9DZxOH-=TUgS3w@mail.gmail.com>
Subject: Re: [PATCH net v2] netlabel: validate unlabeled mask attribute length
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[kylinos.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[paul-moore.com,none];
	TAGGED_FROM(0.00)[bounces-293965-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[paul-moore.com:s=google];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.740];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 674216273B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 9:59=E2=80=AFPM Chenguang Zhao <zhaochenguang@kylin=
os.cn> wrote:
>
> netlbl_unlabel_addrinfo_get() checked the address length
> but allowed shorter mask attributes to pass through to
> fixed-size address reads.
>
> netlbl_unlabel_addrinfo_get() only rejected a mask
> length mismatch when the address attribute length
> was also invalid.  A crafted Generic Netlink request
> could therefore provide a valid IPv4/IPv6 address
> attribute with a shorter mask attribute.
>
> NLA_BINARY policy lengths are maximum lengths,
> not exact lengths, so the short mask can pass
> policy validation.  The mask is later read as
> a full struct in_addr or struct in6_addr.
> Require both address and mask attributes to
> have the exact expected size.
>
> Fixes: 8cc44579d1bd ("NetLabel: Introduce static network labels for unlab=
eled connections")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> v2:
>  - Adjust commit message
>  - Add Fixes and 'net' subject prefix.
> v1:
>  https://lore.kernel.org/all/20260522054521.1169755-1-zhaochenguang@kylin=
os.cn/
> ---
>  net/netlabel/netlabel_unlabeled.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Looks good to me, thanks!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

