Return-Path: <netdev+bounces-274310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLunENjGzWmqhAYAu9opvQ
	(envelope-from <netdev+bounces-274310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5038244C
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19CAA3025919
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A25831714F;
	Thu,  2 Apr 2026 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaMHyVhx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55A24BBF4
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093433; cv=none; b=pQOThmKYmD7nlzrdvdVrpzMaxbCTG0ymfF0HNsVrnp+Pcggzf/NCzE4XyKxHp3gc1cjpK+sMhP0y65Ob/DubAZl7YVCxFcc6L+cyyscXeDH26SN5xWsOUAfSP3OVUiH0Bx0RstCnD3+i2OanhAmWLm8SzaC42I/5s25T1JvGajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093433; c=relaxed/simple;
	bh=3vs324glrrK0BhxdmJWT952XFD7qBwYWDe2Kc8eF920=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD1Lqd5powJ8zunfPVl2cp/nm+D7qu30jARFUP4phoP+J3sXB1X9ZMv3BXpPKv4Ib1wnq3Hc0Yzndaq6lxJvtp3T8a0Cw5FaWT2u3JXBBMZhtOlFbsKFuo55UyXRRf2pQa2wluNo27v2hsyToY3G0lMGoE0XQCuDubLJWANsuHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaMHyVhx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so289094a91.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 18:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775093431; x=1775698231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+HUKS/EBQv4QdODV++R3W0y5zmuVAdbUeLNXqcNJKE=;
        b=qaMHyVhxi9Yl8+auhDfHxDbcguDdlsqQMuANwatkt39af5nwYtdm1GKjQq6DBtIPUm
         dU/iSxKMTTVtHoXlkgs5giueaH+HLhEwqLle8hp9fw82Wiv0Q9LvoaCf6ul6rGOzaicb
         N8dcXZvQ6NtbYyjjzfyM573yaYYfV9h/jKrKeTgTJXfpPO/gnhGiAiI1e5dRg9GyYEFQ
         ivg5bt4jNSeIM17TkMsNx+X+9EdyrQhnDA1mUbLrjO79HvtGSwuaIQdTfPxJxx8+XL0m
         TPrG3G8swgy2Hsqrbl9Y0lNGwwaZ7RDDMiP+7TzNjmWPNV5K9QoFiFWk157ChAllpjoy
         CHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775093431; x=1775698231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+HUKS/EBQv4QdODV++R3W0y5zmuVAdbUeLNXqcNJKE=;
        b=SqO3WQgVTskAyLEbb9RnUJJu5s/0oMfy9Cr+VLpMGZ3NgczeUuatmpAxTMCRxGSgk9
         06zH1N+53Jcw/4ltvqsIowNqKlJ7iKJiQzEbHI1tfOXaHrGkOpFoaw73rSNmLjbD2fkI
         2ARFfPnDk0un1rJSUqL9P5NQ6KTkzt+wzVDcezKd3xLurPjgcT8scyLirbVgOUHZmTNZ
         huQ/fK36vN4zO6ETDz+Nm8FkxKhXp4LXjhklf3sb4MDv8Y57Gqvtt/wIEQj2FYrFBEAo
         XqCWRngIBG43xfrpZ8BJFTLLGKBw4YeQqTn4lWtFmtuiqiXpSCtpgBaGhs2H0Vw+c71s
         dxyA==
X-Forwarded-Encrypted: i=1; AJvYcCWvBpah3CNWFcglRvMOI8vNA/g33QGfPGhWxiimb/wf0DplZ5HQgUyeM+HB2nDlfLua9dbCv2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YG/LDl31phBHwm0vX2MwUSQkTWps0xxJUx1f+aaaTNCnE+W3
	zvNa9bWqP5fcxzd+2eoENKOy7hpT0xi+jHI27Vz8Y62hbQFFWgmNQHHp
X-Gm-Gg: ATEYQzzB89YWSPGzI+gmcuqP6I6Xd72ZIFed2ycl7/Jar9iDdabtrGvhV0KrFX9iwgh
	vlAmAfIGb3Fii9EE+pden0D1H3yCkDR2rC2JMLl+yTRr6JVsqwxCYRfMy6Bon0ntJak0E18lWsn
	Ig4Worxq/re0o1BH9cJHgU9iNRcoTfdN+Q3tNUKkhzD37iqxxv4kTPsNvAuB9TTzfFX0ek1xQMf
	f1/DRvwfdT8xoxO2DnE6U7tvjWMIFujN2nniY1+PO2/rHZIGixQQMzV5tcPnsIJ6QMaNMbrBJo2
	SBjR3FQIaSNz0oVDDW1xCiq2CS8ohA3V/DmQAPXnyqPJGcG9DQBXaSjdPq9ssK1ncp5vRq0YLk6
	9YDaA2mB8oZQWWN2/sOMLBziCYZUeti9qUnix0g0Lbm5IMEz0D7jWuv1Eh+mNQ/B8v/KnCyPorm
	I0WpZ6bA1cFTWrs7rYkzZPIcJ9Jo3gxTeGc+/M6g==
X-Received: by 2002:a17:903:384f:b0:2b2:4ded:954e with SMTP id d9443c01a7336-2b269c47566mr59820555ad.24.1775093431355;
        Wed, 01 Apr 2026 18:30:31 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27475ff56sm9794995ad.22.2026.04.01.18.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:30:30 -0700 (PDT)
Date: Thu, 2 Apr 2026 01:30:24 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] ethtool: strset: check nla_len overflow
 before nla_nest_end
Message-ID: <ac3GsHeimWsmVLzE@fedora>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
 <20260331-b4-ynl_ethtool-v1-3-dda2a9b55df8@gmail.com>
 <20260331184637.58b968ef@kernel.org>
 <aczI7FfIScrKhBGQ@fedora>
 <20260401174956.1e526940@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401174956.1e526940@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274310-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94A5038244C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 05:49:56PM -0700, Jakub Kicinski wrote:
> On Wed, 1 Apr 2026 07:27:40 +0000 Hangbin Liu wrote:
> > On Tue, Mar 31, 2026 at 06:46:37PM -0700, Jakub Kicinski wrote:
> > > On Tue, 31 Mar 2026 11:56:13 +0800 Hangbin Liu wrote:  
> > > > +		if (skb_tail_pointer(skb) - (unsigned char *)strings_attr > U16_MAX)
> > > > +			goto nla_put_failure;  
> > > 
> > > bit ugly, let's add a variant of nla_nest_end() which can return 
> > > an error on overflow (without the warning from patch 4) ?  
> > 
> > I was tried to not touch nla_nest_end() as it is used everywhere. But it makes
> > sense to me to add a new function to check this. I'm not very good at naming,
> > maybe `nla_nest_end_validate()` ? Or any other name if you have?
> 
> I was thinking nla_nest_end_check() to match the __must_check
> attribute. But I also like nla_nest_end_safe()
> _validate() is a little long but anything <=5 chars is fine.

OK, I will use nla_nest_end_safe() until we have a better name.

