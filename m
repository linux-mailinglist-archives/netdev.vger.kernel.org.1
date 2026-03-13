Return-Path: <netdev+bounces-267523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGpgJsEztGn4igAAu9opvQ
	(envelope-from <netdev+bounces-267523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:56:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFDB28671B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 437BC30087FD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7874361DA4;
	Fri, 13 Mar 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="prh3beB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE93630BC
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417401; cv=pass; b=UiJUbeWi2muED9tobRyPcHaRIVjp+EhjLqVCXwpd4Qh1rEvea1vnOiit8aSPi64rn09mGqbLnUNy/ZzGSfP+7hgL7kGJKNBAurHsNFYTvoAEBAy/xKXyRvk7et/8IcnVm1XSxiJZ35PxN39pVcXcTumLVVqa15jKSm6FyyRKnqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417401; c=relaxed/simple;
	bh=U4FXZqGedoQo6GHPwQEh4xyFD0HQuCVujMQty+kI5sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpVI42hO87f27sLc1qEED0Hdr/doLIV+TAUO6ilBUI5Ql/S3tGxkjKnTIGuriJtGip3Lcnc/4w4G7hyvCugbl2atTvbIyI4at9DHXZoSXBe0TBRn/Ct2MUyX3FekXlAbFKCqc+dabMqTpYPjL70aQMGg520V0iNTy0absrMT3SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=prh3beB8; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82976220e97so1411146b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 08:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773417399; cv=none;
        d=google.com; s=arc-20240605;
        b=BmWVZeIUXoZUxParkVXJ393hbv8YQdN0NYUthmUwIYxPW4NXxHlY6y+FS1IWBLqGdD
         ktIO85CmwQ24ZLHYVGA4sRoZ7hvgMJOzYmYvGqmNmHWTxHjxqwbtUWGcs1BaVBrYJWXW
         bAS3jNlPOPWULRzphTtwYiV5bZt32ZlS7BYUouCPrhpus/xDBXRwvIC/wig35prf31ue
         2D0Ggk6kJhkHWMlo0JRlufQEHxujehlY6w21IcC1lx2VMtaq4ScgBmOM3kfsZYBNQzD6
         kM5046U9gs1nLVLb0uVYhGtn3S4nYeHXlZqp+lE5fKPX/Q7iMNakogcvwuN8wMB66c/j
         COgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nsUa3+3B6RN4LCDLMBVKPL0aCncmwB7rIzU/94GsesA=;
        fh=Mp2hs9P3BP/QKqpP8CsYi+NLBnHRzFu06/7QBJ/Qy/k=;
        b=UuNiTzbB4Nn4yNyNnFJvAq/uF6dovDHqywOvz+ShNMWcmiduXreoD7C11q4sM418Zt
         mOPXhoB7nF2bbtpm+aws20xhBa/M5W8Lvaq+csKnk5SRMJ/IArYHXmKe69N7ol11KGoX
         KhuH/vHVFoT/EIyjnzG41CKVdUS6xkZeTDdL0ct95+F3T+fXrh2A1KYemvYUu0MK0rHI
         t1LVyFPcUGN2UY7fnGw5hBTTdYK9Qyw456EEmXEvQbCNrrbXlGJAz4xOUB0R4gc8xdKH
         8iY1P1euhS/FjfflnM3WsqDikGLEZMxPHnUPYEscX8uiOeWCwBwP4agjSfOnrEHu0sdo
         Qhqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773417399; x=1774022199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsUa3+3B6RN4LCDLMBVKPL0aCncmwB7rIzU/94GsesA=;
        b=prh3beB8/xEYRcUtT1w+blslPXzk1ky6aSg86RmuyQwYzVBxsUjcuOxPSh6TbxDBRL
         ZdT/RfRiaHHxsoP2Xyw4JPzkhJELWsiTHAY+Z2x1R3EXzS7tm+Em//LusCeuqthDzc6D
         W5sRRM+91FNVNAm20UyHN4cIQ4dBHsTesLlQgOEsn7DWsQGAWvXWQEzGUKMklM5eLjTD
         u9B9oZxXTFYUICV8UH0o6k4a63vyA6MyJM8X7t4Ouv8bot+yPupuw9gCOpunC2XxxGd1
         kLvSouH8TacmErFJOJQPSYo1+g3kB5SFeMnd5/XrWgmxopJ8wqgKBsus0awirTzZZ4K/
         pLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773417399; x=1774022199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nsUa3+3B6RN4LCDLMBVKPL0aCncmwB7rIzU/94GsesA=;
        b=ZigC9FV0HWt45Ej1AC91C1rKwHm87HMpRnDz/Mea3SlWiQJeFzD6fNCiwqBcr+7Ph9
         gsdx6l5pN6sXluqY3m1R4gb/a9gPlpP3bEqWVCb7DKTywxSmA2vc3rolIB+s1rvyiRYx
         YlzbMdxN7htOwG7DkRU8QhI49Mp1XRS3UfRcUEDgWakllJHJPvkqfY36YarxXmYJ68YR
         YbWb4rlCnfnq6G9C8SXBr8Acj/aL3Udxd/cLASYc5NqFXio19GxN0F86N2NwPvcPkRo6
         LmTIpAhYhHBxu11errQL1W+552d/CSZkty+LOhhLwAhZP91CZceTQOLExZixXgS47MsQ
         78AQ==
X-Gm-Message-State: AOJu0YzSPy/Scojo0KCzAELJ/XJGazNdWXpOxv7yjFpUiJX3FXvpCYu7
	rDKcOIZISI138PHVeAXWnJzpFHFTM4UNQ0jdSNK0lMGDRSD4YerGobr0MyVLqaraTmpkhdc/JbW
	uqfTwGbU9vLPgZ3OwVbNQQPOHrwEm1g+RiaK/2J6C
X-Gm-Gg: ATEYQzzCtz+wAorjGo7aW0VI7WzUDLQMAyVQjZJSJglvFYekVZfMqk07rY3BRPTUAc8
	pUxSnqM8d9vJ5IYJ0ipIzWsvKCNTbxRuBaqf6iO19NblWGX8YM34xFK2ToeMaRBJeBZKejrfpjd
	kEJDTtOeefNAfFveijN33XMXRca4pk1qnA1tMkRAqit3odKt6ggeKjjnDWxDQmXytHp3zXf90ud
	KggMa9ivrGFcfKnZ2L+h0WtGaYcYKL3/Z9UlgAbZrw0aGdp5bmyY7UD1ClHj9CVz/b5BOqOtJeU
	9uOuhSQ90oqs6pY=
X-Received: by 2002:a05:6a00:7598:b0:827:28ba:ff00 with SMTP id
 d2e1a72fcca58-82a19711a89mr2559770b3a.18.1773417398762; Fri, 13 Mar 2026
 08:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212058.169511-1-jhs@mojatatu.com> <20260310184713.7e810431@kernel.org>
 <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
 <20260311175249.54abe1b6@kernel.org> <CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
 <20260312165113.773a5f44@kernel.org>
In-Reply-To: <20260312165113.773a5f44@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 13 Mar 2026 11:56:26 -0400
X-Gm-Features: AaiRm50MOGl4w3-L4BgOwap80DymsQR40mcNnEN5B2Df3vQGH6sofP4bOPy4H1Y
Message-ID: <CAM0EoMm0dMRKJyfCH80G=q4PnnTzzKVRvSrAU204FFKMn9NOtQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk, 
	vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com, 
	cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com, 
	km.kim1503@gmail.com, security@kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267523-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,gmail.com,mojatatu.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2FFDB28671B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 7:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Mar 2026 16:36:48 -0400 Jamal Hadi Salim wrote:
> > > > Two of the several (I think 4!) patches we had took a similar path.=
 I
> > > > am trying to remember at least one variant was bad for performance =
and
> > > > the other was unstable. Let's see if we can revive it and take a
> > > > closer look. BTW - none were pretty, it was maybe half the lines of
> > > > code but touched many things.
> > >
> > > FWIW / of course, we have to apply similar change to all(?) callers o=
f
> > > __tcf_qdisc_find in cls_api. So LOC-wise it may end up also pretty lo=
ng.
> > > And it's not going to help the already spaghetti-looking locking. But
> > > even if it's more LoC I quite like the idea of containing the poopy
> > > code to where problems originate which is the lockless filter handlin=
g.
> > > Fingers crossed..
> >
> > Something like attached.
> > Unfortunately after running it for a few hours it reproduced.
> > The action code path (entered by virtue of filter code path execution)
> > releases the rtnl when attempting to load an action module. A parallel
> > qdisc operation waiting for the lock then grabs it and we hit the same
> > issue...
> >
> > So now we have to be more invasive and start coordinating the action
> > code etc, which is not appealing. Thoughts?
>
> I see. Doesn't seem entirely crazy to let tcf_proto_lookup_ops()
> return -EAGAIN without actually loading the module, and have it's
> call path (of which there are only 2?) do the module loading once
> all the locks are released. The call paths handle the EAGAIN and
> retry already they just assume tcf_proto_lookup_ops() has loaded
> the module so they don't have to.

I might not be entirely following what you are saying. The core issue
is not module loading perse. We can avoid module loading in
tcf_proto_lookup_ops while the rtnl lock is released and the qdisc
refcnt is greater than 1 (which is what the patch i sent attempted).
The new quark is when we have actions associated with the filter.

I will send you a much lengthier description of the issue in an hour
or two  to get us on the same page.

cheers,
jamal

