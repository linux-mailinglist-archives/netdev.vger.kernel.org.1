Return-Path: <netdev+bounces-284265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDUpNVis+Wky+wIAu9opvQ
	(envelope-from <netdev+bounces-284265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:37:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ACE4C8C08
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 383E8302F685
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A730C371;
	Tue,  5 May 2026 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCV7vR2c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B52F9D89
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970262; cv=none; b=fEuXCce+4D/F1A88vI5dHwI47i+2Bm4zb5z8Zaro7oPQA1JgDsYnHJS6qCSYaQ6Cw4mY0IoqDn4o1sHyrTSt8yTK0+u42JSa+SgindL5w05dequY+TD33j8oy2rnEH1qS8+wezpvped2zBoNrfZqkB4cInkVWFp2FiVlucLFezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970262; c=relaxed/simple;
	bh=NS61ymXjH9xBfF5IZxd3ftaRRRX71RParCmS0BZYtXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozPWBcZ+kq6mPsRqRtTawurwq8FVyOARjjGkDk+0m6X3+lfbfLUuy2AD0guF1QSUQ13NSvF7q1RPS/eNMKayaX59/ut9QoiLWChH01xtGnVSGYefKsge/grMF12OMgzOPRfZoV/cL/KJW0oAowfAzojrtL1Fy0qOKJkbTDulYUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCV7vR2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9BAC2BCB4;
	Tue,  5 May 2026 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777970262;
	bh=NS61ymXjH9xBfF5IZxd3ftaRRRX71RParCmS0BZYtXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iCV7vR2choTu6H41DcoJAYRkak3WtZ4NQBGEl4AM6Ig7NnHKeWryi3kDWOj9smV6O
	 +x03XfFmHOpQNxk83qO29pZ0NPGg6EuLs+ncT5GM6536aq/K2UNapGoM+0THYrtQvT
	 kbvoX79IYWghR6G8sUDJV/ZyYVZx5C15Jy5CdzQ5irZ+lUF/orE9SR5BvIY19w0cNf
	 ti2t1GFv4WM+8LfM3xD+t4csnEmCantpan4yXhBMAEdtWOkbaW9Ddw/vzhtDI/uL4T
	 oXv+VhuJwYYVbCJh8ZHWa/DEDj8CdXjxZuYJJRJFAZUtunerbAOMxXiam5ynV7z5UW
	 qQedMgdt03Odw==
Message-ID: <07fc37e5-7815-48ed-8632-62e896f8f6ad@kernel.org>
Date: Tue, 5 May 2026 10:37:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in
 hdlc_rx_done
To: Holger Brunck <holger.brunck@hitachienergy.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>,
 "horms@kernel.org" <horms@kernel.org>
References: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
 <d6957853-9d24-4f35-8ea7-ef4376de991e@kernel.org>
 <AM0PR06MB10396920527D0B69CC9D9BDFEF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <AM0PR06MB10396920527D0B69CC9D9BDFEF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57ACE4C8C08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284265-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



Le 05/05/2026 à 10:14, Holger Brunck a écrit :
>>
>> Le 04/05/2026 à 17:56, Holger Brunck a écrit :
>>> If dma_rmb is used it has to be done after reading bd_status and
>>> checking if R_E_S is zero. Therefore we need to move it into the while loop.
>>
>> Can you give more details ? Why does dma_rmb() has to be done after reading
>> bd_status and checking if R_E_S is zero ?
>>
> 
> when R_E_S is zero in the status of the buffer descriptor it means the buffer is
> filled with data from the device.  Now the CPU owns the descriptor. Now we
> should execute the dma_rmb to be sure that we read the data correctly.
> And this we need to redo for each buffer descriptor which is filled with data,
> that’s why it must be done within the for loop and not before and after.

We enter hdlc_rx_done() after an interrupt which triggers scheduling of 
ucc_hdlc_poll(). I think dma_rmb() is needed _before_ reading the first 
status, otherwise it might read an erroneous status.

Once we are here the interrupt has been cleared so any new buffer will 
trigger a new interrupt and call again this function. Therefore I don't 
think it is worth the cost of a dma_rmb() inside the loop.

Christophe

