Return-Path: <netdev+bounces-254060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICPAOOpteWkHxAEAu9opvQ
	(envelope-from <netdev+bounces-254060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:01:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD409C1BD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA6BB30055D7
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0EE153BE9;
	Wed, 28 Jan 2026 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isweHV2d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795513959D;
	Wed, 28 Jan 2026 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769565670; cv=none; b=Ul1MuPWPE0QwcHhi852JKWS3+vmYkMu1bg1MNTUTlgfLGR6b0ViXucqGxtE6Dj2RDMYMNW4hei7WmqGAdJftPIoovkQllujSLZS9wTUlXqf0akEod5FVlrVUZ/bwIbvitol1X3ir7TxrdQJH0vIA7gCJI4pKBvkpFOFR3/opF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769565670; c=relaxed/simple;
	bh=Gr00GdKZwMT1xl0wCRUKWoeFOdFVScGAcnJ3LAFbxsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbBBUhTscInXc/q93uoHtu0NY4obp+pPBwviFqORENKukuMF4c6zCrXRXz/F7xFdOXh05MneQ8hb228r0OnLVzJh8Vcr/LA2k0fGeuNN1Wm12nWPCb2oj88n+n+EpcLNvMe1lLOM2o+Sd6YQKaXo3Q0wKsjLyS5H/CoEWYwg4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isweHV2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D87C116C6;
	Wed, 28 Jan 2026 02:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769565670;
	bh=Gr00GdKZwMT1xl0wCRUKWoeFOdFVScGAcnJ3LAFbxsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=isweHV2dxUPtITOFQHSyPPSaX/Dt5MljxxYkazUMLC/Urtyudkw/ZAmn9TpaMPPqR
	 r6owr/dQ2WfWEfnSNY/MsrXgsTTICTlZyjcIRomAg3Fm7QQLLvwB+I4zEMwQ2EbLEP
	 wKWUcsZ9gnIAneFQ+Vr6e90kbYaiyKKkSQtzd+TjUEnKdcUPOTjjDGkvWPftSjSDuN
	 6GXceShElFxm254WI8VMl7EMxOEHylI1IlWWmCx23sQw82uozVQWai5gGfiXC1PzAx
	 H2hsZ45Afj+f0CNc6GK0D2LqzDSuGm2nhKdbhUHOet3rowcpiAvP7dgbQmjereFwFY
	 0LmpzcJZxv55w==
Date: Tue, 27 Jan 2026 18:01:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: usb: int51x1: remove unused includes
Message-ID: <20260127180109.357a45f7@kernel.org>
In-Reply-To: <20260126070618.53758-1-enelsonmoore@gmail.com>
References: <20260126070618.53758-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254060-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BD409C1BD
X-Rspamd-Action: no action

On Sun, 25 Jan 2026 23:06:13 -0800 Ethan Nelson-Moore wrote:
> -#include <linux/usb.h>

$ git grep 'struct usb_driver {' 
include/linux/usb.h:struct usb_driver {

Please do not send v2 of this one.
-- 
pw-bot: reject

