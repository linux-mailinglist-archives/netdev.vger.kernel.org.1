Return-Path: <netdev+bounces-299286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Q6JADxOL2oB+QQAu9opvQ
	(envelope-from <netdev+bounces-299286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:58:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB7D682AC0
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:58:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299286-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299286-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B78230048C6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB311F1513;
	Mon, 15 Jun 2026 00:58:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FC3B18A
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 00:58:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781485112; cv=none; b=TA2AoirI6b7lRgTCrCdLdq9SktchuGRAPo1f5QQtzLE7y4W6S++UgLGHuGKA+F36Qn2M6zNd0eR4NXrc1b+fu0FNreVcrfj76mPjyD5qJMO5tIpAXWt2lbVkFWzoUKF5ORbYsq3qtrtBU8WyclPFOj9kYxtix9rPlvn44lv7Cgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781485112; c=relaxed/simple;
	bh=8vPjg3CoqBcs/o54H5Vf1aTxSdxt4W4RWVAUCH4I6aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI12tHfdPVNXS5nR09tuq5pfJaP/vvOGG4ANofyx3yUENG6wubvRNg1GmBwAhtVIyKsA8NwlQDiEv66IyPHfMFOY6mVTQ6VL+1ulQz5TCBzVa9cA4qbV/+UEqreyklW9QGxzLwGtcuUftIj3ZaPsrgCaEGFYvzdsetIfYUgEQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
X-QQ-mid: esmtpgz16t1781485090tf91fe7e8
X-QQ-Originating-IP: xLI41NFzWkRT2aRHFAC33FpxRMLgIi+OcZRrqlM1O8o=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 08:58:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3144052327750393400
EX-QQ-RecipientCnt: 12
Date: Mon, 15 Jun 2026 08:58:08 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	vadim.fedorenko@linux.dev, u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v7 0/4] net: rnpgbe: Add TX/RX and link status
 support
Message-ID: <09A74B70DB12CF18+20260615005808.GA81014@nic-Precision-5820-Tower>
References: <20260611100036.36370-1-dong100@mucse.com>
 <20260612184436.GL671640@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612184436.GL671640@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Nl/za/qVmWHIX5Uuwlu1xnaNgV6FCqM+S8qXsDFjOBZegPDlDJce2Bl4
	JvdPxEQ+vrm12jA/qa6sn8MtZdnnbXVi1lpCIu3eDPC5tERWUV1UP39cXgH8s1kyw3pwq4o
	mNHSUnJz+G78FmTY17u+/aar+z4besDhA6d3fiT+FwczPYa730FXC1oEib3KEpNhvijVmxb
	nYHD4wYvpL6yOdrG2n5e6sFZCcMVFpnqXzU5aeWm45aw2Ub7tCwcsxtMUREiS4SYBgG+gBK
	LFYhtTC8tfNrr4B/gsPzgDQorjf17ESJsQPFKRppnffQiw+dtVraC4IfdXw2/uG0boXOnSm
	i+mIpYJQeyiNjMMRanNcx2t4892AxlH0YLblaTa0D4FKgfu5uYvZ4/dFifoe2JFUHQrmweO
	ovnsdTKPEqr6YTrQE3K9APCI2Td+/Otaui8u1EkwJ+jYfDlG1emejOiBsmEqA4ve2sM6HsV
	5/USQWpvDX735Ga4vS7sJkxyPvPxC4VGrS+U+jXquaNFHoA+xjanrR5X+uEV8/slfQ9e5oh
	G1hxXeO+rzUtGqU7saI1PWKjG12ViVwIwkDg6LtpdSqS1x6+ut6Cw/azImo/IhMHYDz/QZH
	rwNEALmz5h3db8pAUT35EgBOpFUoVilnWAeHmgvUvTJDrEyXYl2g1FUmLlUtSa7AOfL5DPa
	cqCHto3bTy2FUj/85ioj6GoQo+HVGaxETpU+bwFXJkft8dVThpMrxogFOuNuWnDFFJeE54G
	I2hjiKmaVjsdDayWZA55SF8sevFpxUrZ2lYCxRSyd4N5HLzgBi+EB8iJVTkZI0i5laz25bj
	BNsAMU1CjzBnhPHro4717WGcq6i4rpesIiSSqpDgJSBZO9bnTRZqI2YoS03NFAkfE5L5M5W
	ULD3QR6i2cNDfLVZWqmvAgW5Pwbtdd3XYKcDioMLkhaTWLPEd9Jrtix12ovx4G/FtWUew/V
	OVPfhuFsJ+TiMmEW2UeXvs8emDFrfsJxeY5bIn8A1WZQdnjn3I0uP4F9zib4DOBaA6DSkhN
	C9sYbb46JBfomWH/eD80alIWv9C5R2c/MW0llkSZfJD9Z0hDrjkBHLVeY62JQcD2hPa9fsD
	r2cVbiiWZtCG6BY+ZxhMaQ=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:vadim.fedorenko@linux.dev,m:u.kleine-koenig@baylibre.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:yaojun@mucse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[mucse.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299286-lists,netdev=lfdr.de];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AB7D682AC0

On Fri, Jun 12, 2026 at 07:44:36PM +0100, Simon Horman wrote:
> On Thu, Jun 11, 2026 at 06:00:32PM +0800, Dong Yibo wrote:
> > Hi maintainers,
> > 
> > This patch series adds the packet transmission, reception, and link status
> > management features to the RNPGBE driver, building upon the previously
> > introduced mailbox communication and basic driver infrastructure.
> > 
> > The series introduces:
> > - Msix/msi interrupt handling with NAPI support
> > - TX path with scatter-gather DMA and completion handling
> > - RX path with page pool buffer management
> > - Link status monitoring and carrier management
> > 
> > These changes enable the RNPGBE driver to support basic tx/rx
> > network operations.
> > 
> > Changelog:
> > v6 -> v7:
> > [patch 2/4]:
> > 1. Fix 'frag_idx' error in rnpgbe_tx_map. (Sashiko-gemini)
> > [patch 3/4]:
> > 1. Fix skb leak in invalid size path in rnpgbe_clean_rx_irq.
> >    (Sashiko-gemini)
> > 2. Fix invalid size range check for rxdesc. (Sashiko-gemini)
> > [patch 4/4]:
> > 1. Fix 'data race on the reply payload'. (Sashiko-gemini)
> > 2. Fix 'asymmetric behaviour' when report up/down. (andrew)
> > 
> > links:
> > ---
> > v1: https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
> > v2: https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
> > v3: https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com/
> > v4: https://lore.kernel.org/netdev/20260526033539.164061-1-dong100@mucse.com/
> > v5: https://lore.kernel.org/netdev/20260528023150.239532-1-dong100@mucse.com/
> > v6: https://lore.kernel.org/netdev/20260604112750.769215-1-dong100@mucse.com/
> > 
> > Additional Notes:
> 
> Thanks for the update and the notes.
> 
> There is another round of AI-generated review of this patch-set available
> on both https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
> 
> I would appreciate it if you could look over that too. With a view to
> addressing any issues that directly affect this patch.
> 

Ok, I Will take a look at the AI review results on both sites and fix all
relevant issues pointed out for this patch.

> ...
> 
Thanks for your feedback.

