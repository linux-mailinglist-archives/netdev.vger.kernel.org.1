Return-Path: <netdev+bounces-262004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOeDLAYvomn80gQAu9opvQ
	(envelope-from <netdev+bounces-262004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:55:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0131BF3F3
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9DE83004923
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A41931354C;
	Fri, 27 Feb 2026 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjUUmxG5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D02309B2;
	Fri, 27 Feb 2026 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236548; cv=none; b=LyDM1Jb0L39AEncH9Wm1R2ndHeHb+XRGpTusW3aYAJf4bokA8nHaOV9A7e3VhXfg+yZHDU/aPjjhAOdCQHHkTweoC4wx0S0ZHL0r+02OpCZX09FT6yNiLrVQGVdYzqBDb6KbytaRG1gByjIak73hhCESdCaabhnfWc5YxnTkMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236548; c=relaxed/simple;
	bh=BM8DA+vrzH4Kr4PAlA/qQRdglCHh8ezdJrAaJjQK5Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0Fp3STMEISAKaW1kjLxxLJVFlDKVAmSj+YqpBB/OzPO/Ooay8KirqiDf7TOAzFSgZCQY5U5P4/ezsn74ANnqg/efOHYZMQEinmOAstcxttuf5uf30FdbTv8NySZ5GbhRjKLT9DZtVSd+JAtX2dYIobUurtdxanen1fxmo65fCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjUUmxG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBFBC116C6;
	Fri, 27 Feb 2026 23:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772236547;
	bh=BM8DA+vrzH4Kr4PAlA/qQRdglCHh8ezdJrAaJjQK5Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SjUUmxG5ouxd5JX4NaC9AaykzO/pIUVdGfj505dHRFc3kEdy6JX9g/c6jhtvvyNOr
	 6xufQ/Tq0c63ugk9Nid+WOf3DYnknrygWpl/FWqwjXn1tV1kmqKlFSna8NHMg98MxU
	 p88wvz5hBBmMRxogIvFo2nW4d1zl9BexbUymIteHELkY93NgN0Px97aHb1hj2kToDu
	 LhdbpMiSfeAFp2xgFUeTBpsvQcSLZy93e3VQMTbEf4wRCB7hyDRCO0rfgTBPP820mK
	 mYiBBLRpA8iLAqKIGxJ6Pux5Umj1x6uveZmAouFzbPDYnrd5cMLAqThvAmuUgQE2Tl
	 5R/pVUiCQWllg==
Date: Fri, 27 Feb 2026 15:55:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: cedric.jehasse@luminex.be, netdev@vger.kernel.org, olteanv@gmail.com,
 edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [net-next,v4] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Message-ID: <20260227155546.6f861f76@kernel.org>
In-Reply-To: <f6885957-998c-4793-93a0-d3cf957ba702@lunn.ch>
References: <20260225-net-next-mv88e6xxx-tcam-v4-1-117f600e41d7@luminex.be>
	<20260227035537.2630823-1-kuba@kernel.org>
	<f6885957-998c-4793-93a0-d3cf957ba702@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[luminex.be,vger.kernel.org,gmail.com,google.com,davemloft.net,redhat.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-262004-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A0131BF3F3
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 15:06:35 +0100 Andrew Lunn wrote:
> > If entry_add() fails after some entries have already been moved to new
> > hardware positions with their hw_idx updated, doesn't the function return
> > without rolling back those partial moves?
> > 
> > The software list would then have some entries pointing to their new
> > positions while the gap for the new entry is only partially created.
> > This could leave the TCAM in an inconsistent state for subsequent
> > operations.
> > 
> > Is there error handling to ensure the TCAM state remains consistent when
> > insertion partially succeeds?  
> 
> Can we get replies to previous versions of the patch series included
> into the context that the AI is using to perform reviews? This has
> been explained once as being safe.

It should fetch the mailing list threads from previous postings.
but it's a bit in flux because sometimes it sends too much $$ doing
that. And other times it causes too many false positives.

