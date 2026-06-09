Return-Path: <netdev+bounces-296928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cMAyM5e4J2p71AIAu9opvQ
	(envelope-from <netdev+bounces-296928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 08:54:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6D465CF6A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 08:54:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=c+oqSdc5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296928-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296928-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8349F30254B0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 06:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E092F7462;
	Tue,  9 Jun 2026 06:52:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042215746F
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 06:52:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987932; cv=pass; b=UPs4dImLz9bg1HhXRtIbtwU/WNNH78BvUiY3sQDerMW72+4nwM+0r07ZCj3KpgT3u2z/XRtx7eLiKefeknRu1nrzyBMo6QMQ6d5rkDVPI0Z0IJPewdN9fEY2HQcvCiJQitTcf6AjF5pcymNVU391owKvhfWX+7JNC9lrQ4e0J0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987932; c=relaxed/simple;
	bh=X/iRlO1TvvmGyp0MM+znIVEUZN5pzHHcxW4d3e8AgKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuG5k9RSjog7S71AqT+FxXPA7G2Q31NvqRcp1Oyxq+hA73bFx/pgOlABsQg4KmJ+tzOUgHeGxKxm9uxdBXHytbkTg0tY7VNx5SshXY1aImkXBCtcp32MkPcSDrBjuPbyHmERGMWFXNAXN5/P3rwhFsPtFVd6I9OU5h43nvYAShQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=c+oqSdc5; arc=pass smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842288702fbso2058302b3a.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 23:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780987930; cv=none;
        d=google.com; s=arc-20240605;
        b=OjgrIy8tbjk3Dr4Gimmwp8ODElUmD/BHGL+rS4elUNj225WzaAu6J/euhQ+qiEeytt
         UeLWaTXP1R9jUotsm3R3q1Tv4dvdEZXzkiGs8NlgFN+jTq0Ls+cw2s+jiW/NU9WAx1E4
         XAQUe29UBXNWRndjlRs/qfqSjVNcdCeht+ipYQczvvUZSfjZj4bJzmebvOYT64n3RIRH
         woGiqt6Ba8vwCB23jrWaQihdeBZaqLoAZxZniB6sAKgFGUve78byvf1Qy6IJQJ45mxfJ
         yabL8mfDCQB9b7FYb5GfM/UFR5OS2D4VSYy8mS2DifRr3UcoIbfAUHYpk8wX5UsBaT4d
         gh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7P++uzpx+K3WEIGO/No/y6eG2e3IylOIU8Nw5uNReaw=;
        fh=F5SIwZPCEJ6RPFO5FmSqekmMdPz8af1oJypOUxZ2YvE=;
        b=jUf4vvn1day9QQO4AKgD6XnNZzeQnx2U5TtQvY6gF8//QcFjbdN2oQYU0dhCcE62nE
         IR4GkrXrdUMGza/BtQS7exBJqac3Iz4v6MHqRQVTD/Nr1pyna3NV8F1F73594JRoTxwl
         RzIho8TJ7HqhWsTVU1dIeDB0iaPOc5uOBjXRqPq5kbQ2EpEi7aMDMc6gU75x4k3Tg6pK
         IHIHewJenfLiGuD1EPc+Sds3cgQpKr/MARd6+nJXw44dvJ+I4HDEo+q20eFg/p+AxTqI
         +3taJf1evyiwcRy5pufXi3YOuECsfcoc9HN1Xcqm//0d51ZJ/5y6jfjMkJPRyRaYGLn9
         Fwtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780987930; x=1781592730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7P++uzpx+K3WEIGO/No/y6eG2e3IylOIU8Nw5uNReaw=;
        b=c+oqSdc54wht9ham5Syl6vas9IE90KCvOVvwLE4wNP+q9JcqLo72HCGbPMbzscSeaR
         oZ6psLqQVWR83ygwWPKxIZ7IxUCZ2Yz4cl9YSqVgCHsoJ6Sa8TogGry9BufKY/j/5xeE
         MldYaKZakNoynCNrEXhMbLf+b4vaKmxptagxH6IUPFMaNhfj9GZjdodGByuWwm12w+vb
         EH9mUZx703irsLvzRf4ZrREbAmBTL7PIdYKGw5ecjX6c1Uf6V1TuqC8eZ0mkv8d+JGj6
         ZA7wu8MrdPq6HQ7qIdAZqetgM/cjZ01sHZlPUlHD/jf0vsrbpAmsccqp9n4D6VgcnZu7
         V/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780987930; x=1781592730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7P++uzpx+K3WEIGO/No/y6eG2e3IylOIU8Nw5uNReaw=;
        b=Pa1ueh5ljnpcOnDRLC3mxAn/ckMIBTf2YSvjjPSER6uYSTd+0kA2SK6Dei/9aP2hy/
         hMndkGQilGeiMICr8Iikqq1MYWu3pLT+/y77QHSMSuxV/MJHBuBGlyS2bVWpn/3+PStk
         0YscrsZSseOfiW72ZdHnfcKGS+g/4+1IqxeVtJEuQwm95UfXUrMQlNIT1At0FYEO0PeX
         vqdNsG8vc4Ok616AKzp4gojtkh5BYqU1qkpUGwYWTXZ9P8e0YUgPr7/C58fFouWpBtiG
         pl4LnM4M96f7vdAEf2EtVNr3xOtpRcNiOWHAJxARwZQxQy6gyomqSo4p/7SsXgqevYTi
         8eMQ==
X-Gm-Message-State: AOJu0YzUTMToJocFDA5S7QwdHJOjIh1dT+uS7DGw1v62W9AgDAAqSOwd
	DVraVXcv6P7TG2tKOMDFih4JdyXIiBqaFpnMV8bxXGLOtm3K1popE5O8r0ZPjNdgw3Cq4liURsN
	n1tJzmtJbCgD12nNfa3q41hMWFWl9WJfo45Gv9Aa/
X-Gm-Gg: Acq92OHw9ykSmd1aULPsavAQiReb28BwfymQ6E6woVwxDuhA6PyWInQ6MAArdJN8rkg
	sIH3m+yITNSHQwZYK8AV78F95oX1hb1n4E8T4W2Q+PnD/0WNXpihZqZpWQQ89T/RT5BeaO7aSmK
	Nqqv8+VKTGlgyDZTbOvfElvoLJDSLfNsBjDuB0RrOiCLZ9gT7FFdlwhGkb8BX9ifw8kMh/otPsm
	UqIYIuB7umymMNeMjhczs1DWHAC7Lu9JKrK68MpmJ+OF4owzo5zGB6VLnimFuwZvCanDnl7ZCMJ
	5sJ9MFD0dcy04vN/4w==
X-Received: by 2002:a05:6a00:acd:b0:82f:776f:a78d with SMTP id
 d2e1a72fcca58-842b0f9987amr17980453b3a.19.1780987930373; Mon, 08 Jun 2026
 23:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606215848.1951633-1-xmei5@asu.edu> <20260609064613.GA652158@shredder>
In-Reply-To: <20260609064613.GA652158@shredder>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 8 Jun 2026 23:51:59 -0700
X-Gm-Features: AVVi8CcNtq0vP6OjZjLU7YHKFAxa-n9jLGai9XO-aEAr0BaDLTn9EOhL3ZDIi3I
Message-ID: <CAPpSM+QGAARoC2Jq2EfMkXCgBQXy7k64W6rBFdJ8mhpfrR0zXA@mail.gmail.com>
Subject: Re: [PATCH net v3] bridge: cfm: reject invalid CCM interval at
 configuration time
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev, 
	razor@blackwall.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296928-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:bridge@lists.linux.dev,m:razor@blackwall.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.linux.dev,blackwall.org,davemloft.net,google.com,redhat.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,asu.edu:dkim,asu.edu:email,asu.edu:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F6D465CF6A

Thanks for your review and the tip. V4 was sent.

Xiang

On Mon, Jun 8, 2026 at 11:46=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Sat, Jun 06, 2026 at 02:58:48PM -0700, Xiang Mei wrote:
> > ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> > the configured exp_interval converted by interval_to_us(). When
> > exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> > interval_to_us() returns 0, causing the worker to fire immediately in
> > a tight loop that allocates skbs until OOM.
> >
> > Fix this by validating exp_interval at configuration time:
> >
> >  - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
> >    [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
> >    netlink policy so userspace cannot set an invalid value.
> >
> >  - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
> >    not yet been configured (defaults to 0 from kzalloc).
> >
> > Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.=
")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Suggested-by: Ido Schimmel <idosch@nvidia.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> Nit: I don't think that the Suggested-by is appropriate here since I
> merely had minor comments on the previous version.

