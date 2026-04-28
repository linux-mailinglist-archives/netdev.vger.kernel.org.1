Return-Path: <netdev+bounces-282050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLj+GokA8WnubgEAu9opvQ
	(envelope-from <netdev+bounces-282050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:46:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E240748ACF3
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 962133037EEC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2C847B435;
	Tue, 28 Apr 2026 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nly10/IP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2547B403
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401987; cv=pass; b=SHSgecWlrvQUAPNxXv34yVUIObLDhXZWUqSpKn8ltqNihxbeSihkaMjL6zffNtVfQ9zASiU45xUkCiDS+p9iykzCo0gjk7lTV++rUBiTc86U4aptPtHpGWJj5MsZOCRz2msChle3ZbFSiX3l2XcgGnyJrQkhzTrwuW1G3oH/0JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401987; c=relaxed/simple;
	bh=rEtiQB7F3yfpKTXtDE6xOEkZoEUEpURybsk0EzNN1vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bn+IYm5GenxHHGocG1v6QUoJVP/xr/EAm2Lo4GrnbuVXjY8wNDIyNyo32kjvuXvudny/DRExQ+NJhFxUIgXa3u/0vZSkEvLzez8VtXBQMoijf0Ak59DtUthxaLYsc4IJcZyRGt4Pc8jw+5uBhLIIoiM9nxB7YzZ6gO9OYVM4OvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nly10/IP; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c45281a06so16191274c88.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777401984; cv=none;
        d=google.com; s=arc-20240605;
        b=XQCSJG/FJWSaeshLMqrMHA4Fal8KnMnN7ajkAGvIzVsnzaur2vCKNBl0e4vYP0mQ0w
         LCt/jDPqokFLHVflaXntJeL0LuWZVHVCrKR1Q8mllpkNA1RWZaPUBd2AltcXTRDC/ek2
         nPql54xUQ/4cHgVwQr3tf7rAHM7/aoPkchPjFW1jGNDwbS0IEFYo4w+ptXDzwFNGqRTt
         uwxz3LoXjxs4iCmqe+C5vb+/5kzhrPOjd0vX9VM4UTbJAfhVgjBeKgfTgUpmjCaX3kmf
         33FTyxNZWJr8Lqe69tmeOvF6tgt66p7s06qhid2Gsn+jgqGJx93l41cyYpCPtPVP62i5
         zpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dtWL2Nmofu08jaaEHqPK+HWLFx++QkkniP+LH/qTdYE=;
        fh=fdOD5GA4QRGl0HS4prJpRqNNildzPqSTsY6QEHb2L9k=;
        b=PrHoIcxADxqzvkm11W12JtM3GgrJYRRY9Zn3RUY9K/GtiJNDqSt+waIgrWHDtPhFyy
         FCF2Ny1qCshT5V/Dn3Or9/rI+0AAp3TCaFdlzeCnJm2yxtOZT5oQr4m1CcH8M8QqkN37
         S9MjULRtakSMYmH7ku0jS3JgcovEyqOxVWc7TzLrTZV5KbqHQLXzpMJB9eBmOCX7WRk1
         O74x6I8848K7sQjHw2VOo7NUscPub/Tu42XImSvCRBR+GSVA+7/ACm+5YYg4xFbC1I2r
         buGzx3XDPDthFJV3rC/KWJ3qJb3BkPBQficJICInI9J3YbXEOZ3ZUSTbqzqKLdfWr5TK
         gaHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777401984; x=1778006784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtWL2Nmofu08jaaEHqPK+HWLFx++QkkniP+LH/qTdYE=;
        b=Nly10/IPrXGK0xUIyGHWhiMIa0B70CRVp4Yqm+ey7CL5w6LEtPzKz+TX3E8UjwQSKF
         thFpdCUgYEFoK/4PuJhdCrpGUkqki59kBsf1vsMW8zxufiDZRi2yNu1FD9AI3HeaAwQL
         tov0T//mvg4Z/L/J702qfseCMaQzFWiuuRTr5Zk0H9QbJMskp5iReiuvy5Rzo7gBsWhu
         2btWboWQfpEAgow/HGf4eYzxLVB3DkRNtUsiok+x2bpjTkJszmwYsHkiN2xksjaNTV6y
         CDVvGg+UR9CSLBAzGBTIYUq7s70zp9Qld9IDaTYaaXf6+dCahLo5DsCkQsdQsu51IML3
         5Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777401984; x=1778006784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtWL2Nmofu08jaaEHqPK+HWLFx++QkkniP+LH/qTdYE=;
        b=DIspQ4NR8TO6lT2VlhTFAlUXRYcIuS4Bedk2+FY44jrdsy+tsynqOODzipYjktLPKF
         VqEKz/TDDrhyAxmhzLMfYUfvMGb6CobQDWr9G1JXBOy6vX4dGkdcdEi9vuYLiG/F83ew
         z4/nNUQuHriry2A9rQo3XTWcAWx0OXzbhBJGNAvNjt1Jq8tA/XTeGBVoN5Rughraqvb0
         oDBNp6G8J1/wzxt09SUZme0dfaqBXpX+951sGq0C037eYH+iYNPjEZpQW/T7DVpYuENz
         8bVVB0vmTlvGgdhN8InhaJ9pSkP3e9b1JfVrybxX6rgUhQwgdcf1UhZkUrc1RAj17dLU
         V9fg==
X-Forwarded-Encrypted: i=1; AFNElJ/Zjoj9T9ydXYsxVOUDfZUgCwPwcFzeb9R5hZA88t2ce0mJSC7TAcBHpODe9F1iRnoVwSSyxiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/eMdcnUZ/QUjkaSPOH8wJfGg3bSrWe+EqgFQBCO4uN1Q/2b6
	yu2Bki2Za+FQtwpKkJLyqH6bfmTmXARSFOfSlyqaII4iCKdilsI0zPRpJPbfykt0L8VbomZWY7z
	omt/F+OU8bUtMQbwStfoBFrsU5LdLQK0X18oJ4bYsk62sMAruSbfNf79/KP4=
X-Gm-Gg: AeBDiesDDllnCAMn3K/xyJVqdR8SII7EclOX9EbPgf8whSpV3yQpgdNdBphtfXkaLC/
	+pBTErBCVEniE1NMZ6uvjCXO6ykHOuy+3g7lRoqydtyEBWe7LetbWXgtsc5fMCXe6PNlJpRm83h
	+a4nF7oprdzpV/XNAacZVHAKd8nSAiZwdWqOMePPfI9EAj6t8IugkwiL1Q7z0a9GN83zWlkmuYz
	uyKnWkT9DuWnW+UANU3Ty90PhNUcf87u/RqSua2472nNs2ZiRanZdudFtZIv25sjtXxIwTBGdxN
	DK2SOx/xEPhKV/OAmEaFa2mb2uUA3NUHmf39T66xW29wPrLV9HpdE3/Lpx+uKdjPy3wJrnvk5tk
	Qww9kYW4jxdhCwYFDiVSU0AbT8QoXyrOWSRzziO7bHAMz7ZG/0V55UnZMNYsRZ6/h23JsiA==
X-Received: by 2002:a05:7022:4188:b0:11a:342e:8a98 with SMTP id
 a92af1059eb24-12ddd8b02f6mr2077359c88.0.1777401982374; Tue, 28 Apr 2026
 11:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427224243.3499162-1-sharmasagarika@google.com>
 <20260427224243.3499162-3-sharmasagarika@google.com> <20260428111855.GB571865@shredder>
In-Reply-To: <20260428111855.GB571865@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Apr 2026 11:46:09 -0700
X-Gm-Features: AVHnY4LIPo9NRXAYKNpP_C7ZD7DyMGfYzFjap98K_N3B6fceOtmrPZDLKWUIZM8
Message-ID: <CAAVpQUCY_OEUj8UyrAz+RYfxL1konQGs4xKZQLdRMBxW-4kqDg@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] selftest: net: Add test for TCP flow failover
 with ECMP routes.
To: Ido Schimmel <idosch@nvidia.com>
Cc: Sagarika Sharma <sharmasagarika@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E240748ACF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282050-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

On Tue, Apr 28, 2026 at 4:19=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Mon, Apr 27, 2026 at 10:42:23PM +0000, Sagarika Sharma wrote:
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > Without the previous commit, TCP failed to switch to alternative
> > IPv6 routes immediately upon carrier loss.
> >
> > It would persist with the dead route until reaching the threshold
> > net.ipv4.tcp_retries1, leading to unnecessary delays in failover.
> >
> > Let's add a selftest for this scenario to ensure TCP fails over
> > immediately upon a carrier loss event.
> >
> > Before:
> >   TEST: TCP IPv4 failover                                             [=
 OK ]
> >   TEST: TCP IPv6 failover                                             [=
FAIL]
> >
> > After:
> >   TEST: TCP IPv4 failover                                             [=
 OK ]
> >   TEST: TCP IPv6 failover                                             [=
 OK ]
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Signed-off-by: Sagarika Sharma <sharmasagarika@google.com>
>
> Thanks for the test. LGTM. A couple of nits below.
>
> [...]
>
> > diff --git a/tools/testing/selftests/net/tcp_ecmp_failover.sh b/tools/t=
esting/selftests/net/tcp_ecmp_failover.sh
> > new file mode 100755
> > index 000000000000..f857d5db84d8
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/tcp_ecmp_failover.sh
>
> [...]
>
> > +
> > +test_ipv4
> > +test_ipv6
>
> Maybe squash something like [1]? I ran the test without the first patch
> and I get:
>
> # ./tcp_ecmp_failover.sh
> TEST: TCP IPv4 failover                                             [ OK =
]
> TEST: TCP IPv6 failover                                             [FAIL=
]
> # echo $?
> 0

Thanks Ido, I completely missed the exit code.
I'll fold the diff and fix some shellcheck warnings.


>
> [1]
> diff --git a/tools/testing/selftests/net/tcp_ecmp_failover.sh b/tools/tes=
ting/selftests/net/tcp_ecmp_failover.sh
> index f857d5db84d8..8b7a2d82c442 100755
> --- a/tools/testing/selftests/net/tcp_ecmp_failover.sh
> +++ b/tools/testing/selftests/net/tcp_ecmp_failover.sh
> @@ -205,5 +205,10 @@ test_ipv6()
>         cleanup
>  }
>
> +require_command socat
> +require_command tcpdump
> +
>  test_ipv4
>  test_ipv6
> +
> +exit "$EXIT_STATUS"

