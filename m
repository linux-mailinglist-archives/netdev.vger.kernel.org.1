Return-Path: <netdev+bounces-292328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO1NLnEEF2qz0wcAu9opvQ
	(envelope-from <netdev+bounces-292328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:49:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298A5E62D9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AC5D3029B29
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC96537419B;
	Wed, 27 May 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWGhodmj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20F372EEF;
	Wed, 27 May 2026 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893323; cv=none; b=At1zEHU3PBp0q+Vdmig6EZHJt20XOdXA8TnfzZMe6AupeJCkg9Lf1r/xv+UjC1vZzFRbauCN3bR3jpshUibUPQkTOESLGrRTFcmSghloMd9sEhOjPLhVM693/KlXtYU4nvNNh+RzOA9WGv9aQpjC73wH8o+Dwi+AKNPQOyYaMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893323; c=relaxed/simple;
	bh=zwW2rAEt7nG/+CS+RCbPei65ZtLlg0tMdqdEAZbTFTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngrV6+GibGqqlwWjcqvhaTIkNNYFyMIYDGPZA3XASOQQPUMoqJXERDm1K2XSzffvn/3fIbfLgXCE0/m38D9UivjaqT9GhI4WBTigVUATTVBzjGF4nhJ7WXp4QFVRNSytiIY5JRhoToHcN+NNEaJ0TY5Z/dmB0wzwcv1LhySR3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWGhodmj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83D51F000E9;
	Wed, 27 May 2026 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779893320;
	bh=XeeLia+7inK0SVjRYACi7xr71lILIT4nkxIekXATx6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IWGhodmjdQTijclsRkmlDapLOBDo6nNksHHivZSdTVG96YlEP+8+tuFaVMJ7QDZtY
	 pKjhytkg5rzOEqjSWNa4tUBIzdaKfM+XQis474+XZ3PtWfBYUQzR2xpjyy93Gn0JOj
	 enbk8AkvkHuzbaWTvWZVYyIH+medmu502S/kk3mjtZ8+XxEEWsQ0G2n+Dvuiz78PZZ
	 rQqw9iJWVdDYRNxRwPRk3P7EehgfO6+0f2WaEyr775wMhWNjFMwLdLQYyRyXiNPGk0
	 9rMJs3VGGfGcr/K34Qie8+f1tmG+W6aFs5OIKUeSS69/xdbgh7iyRGKYuMgCu9h6nI
	 fDobtz4yyW+EA==
Date: Wed, 27 May 2026 07:48:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] docs: net: updates for old and cobwebbed
 docs
Message-ID: <20260527074839.7a78f1c2@kernel.org>
In-Reply-To: <72e0f118-5fa5-4ca7-b443-b472e7ba317d@infradead.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
	<1c341b25-e720-4f63-9db1-99348c8ebed9@infradead.org>
	<20260526153719.7261b7f2@kernel.org>
	<20260526154001.4a8d30bf@kernel.org>
	<9757813c-dfc2-4979-80da-c3bbf962dc4c@infradead.org>
	<20260526181513.0393ca46@kernel.org>
	<72e0f118-5fa5-4ca7-b443-b472e7ba317d@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292328-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6298A5E62D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 19:39:47 -0700 Randy Dunlap wrote:
> On 5/26/26 6:15 PM, Jakub Kicinski wrote:
> > On Tue, 26 May 2026 17:51:45 -0700 Randy Dunlap wrote:  
> >> It's in today's linux-next (20260526), line 1950 of
> >> include/linux/netdevice.h:  
> > 
> > linux-next is useful, but we try not to merge broken code, not just
> > notice it after the fact. So it'd be great if the fix made its way
> > to Linus and therefore propagate to subsystem -next trees, not just
> > linux-next.  
> 
> OK. I don't quite know what you mean by that, but I just checked the
> current net-next tree and it's still there at line 1950.

Sorry, I'm talking about the regression in the kernel-doc _script_
which was recently fixed, and which hid the "excess kdoc" warnings. 
I'm guessing that it's fixed now in linux-next.
That's why you see the warning in linux-next and I don't in networking
trees. What I was trying to argue was that that script fix should be
sent to Linus, not sit in linux-next.

