Return-Path: <netdev+bounces-165167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1ECA30CA8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265133A67DB
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82F1F1908;
	Tue, 11 Feb 2025 13:16:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28831FCF74;
	Tue, 11 Feb 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739279790; cv=none; b=bZENJdGmfP+75uhPV5YcUmm0r2g7cq7aV57IZQ3uD0treuxo2sGdxryZb6fqsI13rvCRt9HEHBJbB8uxgObl72dxGYhwI74+a+KulialHKkwhsDWHpq/2OSjaIGXpNSvcTkSsBpHedg9zDknNenQ4Fwr0kjni240AudHr0Ck6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739279790; c=relaxed/simple;
	bh=M5ePXotyI1dgXf1FYkHih4HZJzuu/y5R1IO6sfCSaGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvuZVw26fr8vireCnlNO2hHH34pby4yo/AkLxfmdKGfPNmM07WBrAh5yiwbmKAw9fK+L+ZxegsNt0TQN92iP4L0RspkyAlJHW0q8q3rklO1NgzxLNQEwaXnNFjVcP5j+FC60ax73+ZD9cNe/D/PuL129J4r0XA72F/IVJyUbAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de594e2555so6054357a12.2;
        Tue, 11 Feb 2025 05:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739279787; x=1739884587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+06crTRuZfGYr64hF4V/220jMT7lXT/btS5w2dXsgM=;
        b=uLHLXFlFZu3kI8xlTdv8bZSEvMOao5e3hjDFAN2lLgSqY/wR3XyS+p7ssr4NacNx1b
         SQqjKPbLoXIlZZDCR5Cc3JsGplcfjpXW0S3f2PEl6hafsK5B4zGs70s7BCbhS40C/4yt
         N74JGba4sBdGPCLO6P7Zh+QXoUynlqo9vAywMVa325Pp3D6miSmsKXTa1OQMVI3uk5ZD
         fRbzqIChQar37dfzSydyNeP70FSnephtVRTRlWymh0hjeGtnp3EYdKinItojFn8ctYyV
         d0BRQy+WmKvp+e1RshI9hU39PWgM5rTPyBHXbjlqq41aWune6Rd+KMdcmc5UOuqX2PI+
         bqpA==
X-Forwarded-Encrypted: i=1; AJvYcCUaR2aLAD7ecY5ZvsEcMJe3tlDpGbWiuJrX/vkUO3aVQru4fn3ZpLn2AOKnqrsOEPaqnzT8C8te@vger.kernel.org, AJvYcCWE1u7J5hjilT2aJvDvmsPMzZe/kYXqnLSwP56KkuEsWyFcBOEd/w2re13mbvi+nXF9LIJKpdLvgqOY+Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrAtNVVTvia/k79rLi06Z5YER+GcrVeq+T4b9f4WTPpFRum7yc
	gD66GxgeTUA0nEIZc/JensNdjcZ32TbHuwa6YF9mQRPQM72yh/r+
X-Gm-Gg: ASbGncsyeBV4oOyZGA1zNiRz5ARgOGiKO6vNpxy/pl0hRkdxgPlF2ORSIQsIbNVrc3P
	nfoKtxdI/KPKNr2PaPRiBW1X5NDNlesvcHeG5+BbQ8xGAlR8/+9kUTD7d2sP/5RDv/aM0nAq4VV
	ZQY6LyjhP/rNFuXPAxuLWQOcwPbnklc2twpmIaY5jwET6y3aq43ZKXeMCCbNHgkKziIJkiQNqsd
	5b5RWSOrcK4T1r/9cl3gRcJU755pAIhIfQhlDTFbgdvodnaHJWPVcNS89GfRDt2V7dmtVB8E/6d
	ZRk=
X-Google-Smtp-Source: AGHT+IGwzosxVvzZG/fDwVDmTqPGgBsdD+uvVagBGDKO4bq/6IrvlVy3waqq96Dt4HVKS97GY8J0rw==
X-Received: by 2002:a05:6402:40c1:b0:5de:aa54:dc1d with SMTP id 4fb4d7f45d1cf-5deaa54e090mr378936a12.1.1739279786664;
        Tue, 11 Feb 2025 05:16:26 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b7b0a2sm9546260a12.22.2025.02.11.05.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 05:16:25 -0800 (PST)
Date: Tue, 11 Feb 2025 05:16:23 -0800
From: Breno Leitao <leitao@debian.org>
To: "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>
Cc: Uday Shankar <ushankar@purestorage.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH net-next v2 2/2] net: Add dev_getbyhwaddr_rtnl() helper
Message-ID: <20250211-spectral-golden-quoll-ed1af9@leitao>
References: <9B3D8CD0-65DE-43FE-88BA-55902DE96496@amazon.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B3D8CD0-65DE-43FE-88BA-55902DE96496@amazon.co.jp>

On Tue, Feb 11, 2025 at 11:49:14AM +0000, Iwashima, Kuniyuki wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Tue, 11 Feb 2025 03:36:43 -0800
> > > > +struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
> > > > +                              const char *ha)
> > > > +{
> > > > +   struct net_device *dev;
> > > > +
> > > > +   ASSERT_RTNL();
> > > > +   for_each_netdev(net, dev)
> > > > +           if (dev_comp_addr(dev, type, ha))
> > > > +                   return dev;
> > > > +
> > > > +   return NULL;
> > > > +}
> > > > +EXPORT_SYMBOL(dev_getbyhwaddr);
> > >
> > > Commit title should change to reflect the new function name in v2.
> > >
> > > Separately - how should I combine this with
> > > https://lore.kernel.org/netdev/20250205-netconsole-v3-0-132a31f17199@purestorage.com/?
> > > I see three options:
> > > - combine the two series into one
> > 
> > I would suggest you combine the two series into one.
> > 
> > I will send a v3 today adjusting the comments, and you can integrated
> > them into your patchset.
> 
> I suggest Breno post v3 for net.git with arp fix and then net.git
> will be merged to net-next on Thursday, then Uday can respin.
> 
> If this is posted to net-next.git, the following arp fix needs to
> wait for the next cycle so that net-next.git will be merged to
> net.git.

Why not sending both patches all together in a patchset against
net-next?

