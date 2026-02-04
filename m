Return-Path: <netdev+bounces-256687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK9ZNQQ4g2kwjAMAu9opvQ
	(envelope-from <netdev+bounces-256687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:13:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3549AE5A39
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E4F030238FC
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9433ED126;
	Wed,  4 Feb 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIr7YRM5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E773ED11A
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206903; cv=none; b=mkVaDwYQv1qjVciCKa3OF/0sr023Y8NiPRnMd3Yc1FaSr3KpHfPPAL6Bz5Ckt2nn0rI7TOqxopKXj4JohW6xzlZDiyhSCbeZ7C7++92AI9Z8lRpHzteEpkmgHsj1xM9qgZmzn5aFYnwzEXnk5LtChoHIZxEhMiCv2CI3jvFCHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206903; c=relaxed/simple;
	bh=0t+tXL15cJtzOgmIlBvdrfTA3tDyLplIdYq8kcwmDUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElDVDrjj12bfB0Zj2C+FCVYHm+ahXhJV8y2/B5dIJbPBgVJ1PGadAp+FBU2sPQHv4LENCsNQr8f8fjZmtW5Ce98o6O2TbxRqVD3g8fjoQ7vr2f58azUNIhrcIzshx52U3oVIFzYhksykk/QRfH4PYkHZPCDSG9aNOjzh3uda51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AIr7YRM5; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43246af170aso596180f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 04:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770206901; x=1770811701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioG9uYV0HuJP9D1DgqNAsKhOMqjhdFQVQ0SW047PMUE=;
        b=AIr7YRM5vayvaqnsm8eOOu7Q1osYzpWKW/nmd1Ki4/81p+V2W21R26/YuB2ZEKYku2
         7NfulbJktMBG38DvAl2ipnH1vBobwikzHmH5Ofs0HvGPGt33EKqEKnOjlvURSH1qazNl
         yDsfXnLu7/KvZMlfIUbj+Z6a/nE3ysFCzG60qAv3K36ofEkHIt4N5H0exxJtof4EMv7y
         iy2aHUlfHTdRnZlVITvDFBfAssbnwIom9Y3+CXN21UaBh7tSRb6BolehAP/eD2QUw6Bs
         usSGRS/VWbuHuxFq/WB00Z8AoBOBtMMEjoc/YoRiYGYCsBOIQijT+R9WZjoUUkhqgFfa
         0DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770206901; x=1770811701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioG9uYV0HuJP9D1DgqNAsKhOMqjhdFQVQ0SW047PMUE=;
        b=vaSdPrNw4WBVJt4DDREqvSFbyUH4k1BrQs7mZx39bRQKv5W017/mI0YIGvLFkz5i6m
         xE2Ac4KDxxlR08MclzKxgaELJYwEi8D12Xu7APAPOLL2eBAbp0ZpD0xhs/aH/zsnaTcj
         kzRgABHdjKdx5WOB3SGMBZEF85zW3qGE/D97/GTbpj7c8X1uW/LxHCu+/7EJH1R0frqG
         NDe6AjPUs2xPkmUXrdyAZO3dnWPM/cDI9ETKXsUfuUlkaT2bHBJ+SUZ+ij+IihaimoST
         rW0MIbeK+68qw1Npd9Gow7mRcDR62bru1saAJv+1tJHufpDpKzMBbWChYTLvFkVhXopX
         o8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXkvOC1/Im5lblviiLVWMcTX5MNFzjemSEMUon4+La4HwEJjWXn1uH+0gLKglZn9RygMObMUa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfdNRyPCpM/Y7+az0UcqTvqB/SyZoHjifTr2Kivyyg89yqUmE8
	J4rDZ2RwRA+jA1Z2ttBibIwiRsdOcm8AgkyRrupWX8qHukz80FSWzgqxdEN9NHfX0WA=
X-Gm-Gg: AZuq6aLW/rHBR15Vux9ZueSuQ5fw4dJXzJFXT3iIQkBnxe7w67FWmwDPSwqLeMwsbsg
	7T0ew7ymQJkVZaH+c4xLEteJhsz0j9h3VmakEc0dZLhMGrWQUicy6AL1YVv89GuW3M0jwZFpoM6
	zNFhCB0FSZc+lW4bI0hJ1HeZsYfzAZpkECA/TO7cM655mzgzvGnrtN+qEw2Xjs8/ngeIBwDFH2p
	m+re8tZccKhS7jM1xvfVfbOjkGokhh0yDPnbYK/QQ1FK1OsERmSG099u/r4bgiWsS7U4onBU8k8
	rBbQPQSnSszz/KFIFOfM42Nw0GGhnZiW8DYRwYjgIFqjjug1vuTMyV9wmL7BWaZyCxrv6jvpdZ8
	6ePz33p2+JcDnIJ3mAjeBXkThYmQPPAz8Jy6xVtu4HPpMaRi2bbrvmut8Kd1vzyUSYS3/DPgG8k
	v8KzcarKroE2fNEcV+40MBFGxJRVs=
X-Received: by 2002:a05:6000:288a:b0:435:92c6:d556 with SMTP id ffacd0b85a97d-43617c84202mr4190603f8f.16.1770206901187;
        Wed, 04 Feb 2026 04:08:21 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f7csm5851345f8f.23.2026.02.04.04.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:08:20 -0800 (PST)
Date: Wed, 4 Feb 2026 15:08:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>, linaro-s32@linaro.org
Subject: Re: [PATCH v6 0/3] s32g: Use a syscon for GPR
Message-ID: <aYM2sXq2FXCISrCI@stanley.mountain>
References: <cover.1769764941.git.dan.carpenter@linaro.org>
 <bdb7cd69-7dcd-4e8a-b04a-14a2eb902311@redhat.com>
 <20260203145438.5a850b61@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203145438.5a850b61@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256687-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,foss.st.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,nxp.com,oss.nxp.com,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com,suse.com,pengutronix.de,linaro.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3549AE5A39
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 02:54:38PM -0800, Jakub Kicinski wrote:
> On Tue, 3 Feb 2026 12:18:54 +0100 Paolo Abeni wrote:
> > It looks like patch 3/3 depends on 1/3 but it should land in a different
> > tree, as patches 1 && 2 looks suitable for 'net-next' and 3/3 should
> > probably go via the arm/freescale tree.
> > 
> > We either need explicit ack from freescale maintainers or this should be
> > split across subtrees, right?
> 
> FWIW normally we don't touch the dts patch at all, unless the
> maintainer chimes in and tells us to take it. No waiting for acks.
> Off the top of my head us taking dts patches only happens if 
> the person posting the patch _is_ the platform maintainer..
> 
> For this series we're waiting for the bindings to be reviewed.

Ugh.  Crap.  Rob already reviewed them.  I included his Reviewed-by tag
in v5 but I accidentally removed it that from v6.  I'm so sorry.

https://lore.kernel.org/all/939fdaf94038613486bdbba510a92a1e57e18c71.1769592679.git.dan.carpenter@linaro.org/

regards,
dan carpenter

