Return-Path: <netdev+bounces-291125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEwUEfvWEWoorQYAu9opvQ
	(envelope-from <netdev+bounces-291125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 18:34:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E16F95BFD83
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49A8530067B8
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C108C3168E1;
	Sat, 23 May 2026 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x+ugyyes";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i8J5Tfsn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x+ugyyes";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i8J5Tfsn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071030CDAE
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554039; cv=none; b=RYkk69Cq1hoDglDhHbVmW3tevBMVk8u+dDgvXWJcZRC5GFSfG5dk1XUCp7Cjy6WeMrFwkAHRNdg1g03wueMC9ZWZc+IKxEM72KEfbZBLm67DeSncIIdB6jUMIFFs1npajvJMpTdifZ810EhzBFZPMasqTiqtjIYt14+Y4R9QNrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554039; c=relaxed/simple;
	bh=P0MjXBJI0ms4Ty6ze4FewFYwARJgmIdsG1mY5k/xFSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiTWQbbtz51S5LAvndtrDmZ0+ZKiIzqCIKKJPeDfa56QYSkSdP2+9xcLfAOzU/w9NDOmVtWomvE5lBWM9Ij4MwmNwZr2IiVXOJjZGmiMNrZhJAlPdnl6LOG3JMarnNDmHAKsVwvClQychyMb/EpMbrc3NPNIqWF/4RVIhvHNYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x+ugyyes; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i8J5Tfsn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x+ugyyes; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i8J5Tfsn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BACF46AA5B;
	Sat, 23 May 2026 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779554036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olpBbn3KWQRdTPRy2ziVcsx5dTpjX1Axg9V4FEsoMow=;
	b=x+ugyyesOulGuwSulHUVIH7lFybCOKL6NLsl6iMrCqbiBdmkpBzHlLmp+g9EmRGzfiht4h
	CuywVNed/VJVzn/ShbnjKSfoM4bz4huK/p9Pj0rWpPQO9wMKGk/FwlIFWA7l50Z2e4JOqg
	lBWLMG3gMJDdK/17Rqhfzv9fFvIQo2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779554036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olpBbn3KWQRdTPRy2ziVcsx5dTpjX1Axg9V4FEsoMow=;
	b=i8J5Tfsnxi0I+40Uz57/QaEDEgoA89MPOFbbjguHnB8Vex8tVPzfOGBNwPSc2+6hlwWEez
	dzQdgaWwK117IlAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779554036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olpBbn3KWQRdTPRy2ziVcsx5dTpjX1Axg9V4FEsoMow=;
	b=x+ugyyesOulGuwSulHUVIH7lFybCOKL6NLsl6iMrCqbiBdmkpBzHlLmp+g9EmRGzfiht4h
	CuywVNed/VJVzn/ShbnjKSfoM4bz4huK/p9Pj0rWpPQO9wMKGk/FwlIFWA7l50Z2e4JOqg
	lBWLMG3gMJDdK/17Rqhfzv9fFvIQo2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779554036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olpBbn3KWQRdTPRy2ziVcsx5dTpjX1Axg9V4FEsoMow=;
	b=i8J5Tfsnxi0I+40Uz57/QaEDEgoA89MPOFbbjguHnB8Vex8tVPzfOGBNwPSc2+6hlwWEez
	dzQdgaWwK117IlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01465593A8;
	Sat, 23 May 2026 16:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8hhSN/PWEWqlJgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 23 May 2026 16:33:55 +0000
Message-ID: <ce676478-3360-4538-b73b-810422a4dadd@suse.de>
Date: Sat, 23 May 2026 18:33:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: hsr: fix potential OOB access in supervision
 frame handling
To: luka.gejak@linux.dev, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Felix Maurer <fmaurer@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260523130330.61880-1-luka.gejak@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260523130330.61880-1-luka.gejak@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291125-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: E16F95BFD83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/23/26 3:03 PM, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Ensure the entire TLV header is linearized before access by adding
> sizeof(struct hsr_sup_tlv) to the pskb_may_pull() calls. Without this,
> a truncated frame could cause an out-of-bounds access.
> 
> Assisted-by: Gemini:Gemini-3.1-flash
> Fixes: eafaa88b3eb7 ("net: hsr: Add support for redbox supervision frames")
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

