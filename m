Return-Path: <netdev+bounces-251859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDzYKVzJcGkNZwAAu9opvQ
	(envelope-from <netdev+bounces-251859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:41:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF1E56EE6
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88DAA4FBC92
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69263E9F9C;
	Wed, 21 Jan 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="nRZPBbDk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB2280324
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998926; cv=pass; b=QCi9n9JntBoPgX0L7szuIqwnBci++fffDV8q4fl40RLFhSQpbny/Skq7nwkl4Rmvds8CPD/Gj9ZASBog9KzhPSiSfEWjKAhuEueaqkGwi6CI3SuQ+m27/Ybu7gCXc7uWj6VMO/7gb6+1sOTdK1rVdtHOTqhbjzB1cZArc6RK9pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998926; c=relaxed/simple;
	bh=609IdniIhM5s9yVyBkRF8UQSbuSI291Te2DEagXPIwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFbUwiY8APDUFlF9WZQXryZ9m2NMIkjW6tqKXnUyl18YCeWTSWET/SbNbj/vG5tu6AYb6+EMUUk8FVxuKaeaAWNGrWCDH/ou4sD50aYafLSIzVHCPZktWDtevU5rLYCqu5VU/x9wZw1FaZ2JJ3bmBspOnUCK5/5V6Yh8uqFkjHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=nRZPBbDk; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64669a2ecb5so1251993d50.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 04:35:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768998924; cv=none;
        d=google.com; s=arc-20240605;
        b=PUriY5XQcA+uqjPs9bKg/1DE4zgIDDHsEjtJMSejEwqo7Cb3XROgdsS7Cu6+4F+vQu
         Hsg7XOBfBXpYQQGWIZQj08QbEU0FLWPjNDdJ0aOeXJn9VRRpp+1R//N7WBMPILwMr5cx
         NVh1fcwjssl+eSZEIInx3nrqoTHxmxIFT4hkFtJPC996TN0eopXPoZcSB1jRMKgiLMEe
         1G8uwkgFlfpXOlDRvuKeDvM/iHJ97iM5T/y4JxVqPupxrUFwik8oPYVOyKOd7LtzVFip
         0/9NYK5bUZ71Dxa5fagkHchOpGHwehuV0mQnrzbH28wHi/ON+M0Q9t8pAFIh0eZFLy6V
         LuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h24m7IYRVboGNSvzoCdzZL4vm/l2kIr0FMfsrOCBUd8=;
        fh=8UDauyIvQmqvtQyg6OX+MrsOKHsmZJ56qg3arIzpy9M=;
        b=B9IPkh7U97lyhl3q5IkM6z1to9wReWfC4rFhZlAyhabWGOmnqCzssBk0YpSEwWiG90
         JCqtJp849tLtgWB4UTlkotAiTpMEXtqGNPADG8Xpdw0mZuShNMSiKliJQ7DLqlVvNlUK
         2J16xuQ46Utua9Vet1oZFyp3yj6g59Vv0sV0WF5JHrVNh6nf3npGeAFkYG5ef7uisTDd
         IeE04hFKgAAvaqn2rNiW19PvJa138jUfg/iXgE+84ybGOGHwYnBSUdxQgu+zwfK/woQM
         yD3FPrismCP4Q5fZ1Y9G5QD6TiLtxYMJ//qv2qfO5xKlUA497LsskC1ck5FDvQRIpsc9
         v40Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768998924; x=1769603724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h24m7IYRVboGNSvzoCdzZL4vm/l2kIr0FMfsrOCBUd8=;
        b=nRZPBbDkQqfy7W5qd1QsOz0qHVFqTKNEdPUVyw+7tvfeSyBPVPazf/pc646IsF7Fkf
         HkUC/PV7HdBW8EvakWRgxbsGpWuZakaa5q42XH6P/xz7LFlGm77kaSg2YngrXTuHfDhI
         +DxAjz3eWjVuhSHE01p2a4bAlvjLlPJm5MNwWXG8ufJ050ITcHEKoeBsj21Dv0lzfRa4
         o4zDzblcxc9CJAH8pL+puN3LnVaD1Nw/AS/HU6i8FMWTXUtBjdTAAyBm/WZVsGn+WPtO
         Z5lbE+DA5VnRAiTIvGJw9fgQOm0ex5lnS58HLsieLXfF6t1kOknvjM0e7TWo4rHJkJX7
         gb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768998924; x=1769603724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h24m7IYRVboGNSvzoCdzZL4vm/l2kIr0FMfsrOCBUd8=;
        b=VccQhG7WsFP23Spllke667PKnDmkQPnVRDoB68fuQWr4QDpjFoXL7idmi7hejvpUni
         UFTbxRw6Erk5hniJu1DukB6YjxX4lVpCJD4TO4xtVxeL6daNF8hH/HtwuEDXb13zIJqc
         67AdYHVhEJvgffrOxEVFAdSWVYo0xnLlbo2qIwHTB5FxwXKU9ca3L5keeh6tMP5+N3BE
         bL+5izcwty39mVZA8lEjCsCf8rYJmwD1cOiEwppD9f1JhkbHHHW4kLeDQ6sjOUoEOFZb
         KCWRo6m1/X5mOyKfvyxpqB5dVxpibE5NJ2qez9iDjUY0SiTvSTmr2nOkww7zdXLuEJaj
         13vQ==
X-Gm-Message-State: AOJu0Yw0U8G9615AFYskKw3Yotc6Z0A7RkaLQ0t2t0jr5VVPwoUrEJLe
	3JOvcYtEbEG9IOkXe09LXdHSxG6dIzB7sRmLh1IypunQ3Su0kKrsVOTyG7v+VM+aaHb02KypQTD
	VfU0ZiDh5aIgc5KPDeSeorDGi5rH1Xb1T8jGOQIPy
X-Gm-Gg: AZuq6aIgHgEkD+7AhN1JPbquCQ00CDxq0SNFJ8/4E1ZhKWXvJ22mJyyubpCiVFLTw4p
	og0B+53yiMCk745jLYfbNdJdsXgasc9iZzqKuFijO2VJ/Tiypn/EMZw5hR2fkj70Lk4I9jo8/BN
	xAHUHjAF4azCWOiEl7qCpHrw8V56wlJax+KNhVjnA80P4YGW7hCaBSekRFvyKoZCMNhVWVpurO+
	4kcJGd7CbM6QIxzsWR99UuAEhSizwXhlnEUr6L13TvpnUoMWA/izf/gZvon0y14IGtb6dpDxaTI
	N+C2768UHQ==
X-Received: by 2002:a05:690e:140f:b0:63f:b6c0:23f8 with SMTP id
 956f58d0204a3-6490a67fcf2mr14852507d50.33.1768998923702; Wed, 21 Jan 2026
 04:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120004720.1886632-1-p@1g4.org> <20260120004720.1886632-2-p@1g4.org>
 <bff53f0a-2c94-46b2-bb49-b05d10ae420e@mojatatu.com> <gwO399q2_pH73eDkd2OatN9SsR8aHtm8CbVIEPOf0nuxXjqbjY6vgCqNyFya75mMVicn8NwUgG8zaNFkR_JuZmFk0UcWNCHlpzSxFbaycf4=@1g4.org>
In-Reply-To: <gwO399q2_pH73eDkd2OatN9SsR8aHtm8CbVIEPOf0nuxXjqbjY6vgCqNyFya75mMVicn8NwUgG8zaNFkR_JuZmFk0UcWNCHlpzSxFbaycf4=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 21 Jan 2026 09:35:12 -0300
X-Gm-Features: AZwV_Qg4IJvbjcPkkd12nOg6R7TlbuDONp9DjdoNwNbpgpNIh0g51NPdN2LFABU
Message-ID: <CA+NMeC__K6Z4MyEK8DPTQc38AejwzfyWHckyr63zwL8ZqT24_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/sched: act_gate: fix schedule updates with RCU swap
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251859-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,1g4.org:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1FF1E56EE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 7:47=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
> [...]
> I=E2=80=99m trying to strike the right balance of input validation for st=
able. I kept this as one patch because the validate and build before publis=
h path is part of making the RCU update model correct. I did try implementi=
ng the additional validation independently first, but it did not meaningful=
ly reduce the size or complexity because the RCU swap still requires a full=
y formed schedule object before publish. Without preliminary validation, it=
 is easy to corrupt the timer state or end up with undefined schedule behav=
ior. At minimum, I think we need:
>   - interval > 0: prevents zero length entries and immediate refire loops
>   - at least one entry: avoids empty schedule deref and undefined state
>   - cycle time > 0: required for division and close time computations
>   - overflow checks: prevent wrap or underflow in close time arithmetic
>
> I can do the conversion without these checks, but the resulting behavior =
would be fragile. If there is guidance on what validation level you would p=
refer here (minimal representable range checks vs stricter sane inputs), I =
am happy to align with it.

I'd say, for starters, try to keep as much of the original code as possible
whilst introducting RCU. If you think it's still not "ready", you can post
as RFC. Then we can add more checks (if necessary) as we go.
I believe this approach will result in cleaner, more maintainable code.

cheers,
Victor

