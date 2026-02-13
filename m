Return-Path: <netdev+bounces-258635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH/uLb9Kj2moPQEAu9opvQ
	(envelope-from <netdev+bounces-258635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:01:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2BF137C5D
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1145C304A5AF
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02DB364059;
	Fri, 13 Feb 2026 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOCDmnZv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2E2C21F1;
	Fri, 13 Feb 2026 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998408; cv=none; b=USNI2anhDSJ2fbVMm33onnSBxzBs3iHD6o9yDINCEmPnu8sZ78NGhpotjeGc5hJKJpX8JJi0dxEuqJxHNJ7x08X2xZED1iyQVRzBMpDEKR0ZnnkeRNR4Eob4uEQeF0q+y5XzXrlOFUgZ6TbvwZZSg3yXG963VmjVWJeMHhY3IxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998408; c=relaxed/simple;
	bh=umAF/ss9ZcJMBNAXS2atoM4+Zm2UxJfpsD4eEBlFQgU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Xn29ak3WWQUk1Ti6QQtskWjfZEjn97aMn+tZiaoSwdgMSDbA5jiWmF76JhPrkf76ajizIofb/sLvvZ4pSx4orcOQQklhv1/a/WUf0XzHykBqO9M+mrLed3tPdsYg981/A97kR6UWSXqUjsGRPSacA1Evh5MoFmODnr5GJJT2f1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOCDmnZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFFEC116C6;
	Fri, 13 Feb 2026 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770998408;
	bh=umAF/ss9ZcJMBNAXS2atoM4+Zm2UxJfpsD4eEBlFQgU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dOCDmnZvocrVImcWNhWqNPAF4totSSPUucNKUsGS7iDIJta2veoCndZ0s6FbWPuUQ
	 z+rFcHPQPQGHBT6YTqMj86RNJPFcgaW2oFmdcclf9R/+taQlTcD/YwhcwC0K7JwYMA
	 P22PZjf6e0c+YJhILTjngzjfr3h9P2yHkdnZHyYN7iha8HW0XRdCfMK2tXCqSJWB9b
	 nf2wV82FA1iTdsjNArs7z8cUTOkqxSro3B9bgCcX1IwY21obnbDpEVyV42fLNjU6r4
	 MSQI6U5Avn5BZDkGuctNOgDmD2QsKsE5RH8zrwZdIl4R+Y1ltsbpkUaAwZElq1F9EP
	 jXlcOsROuQGHA==
Content-Type: multipart/mixed; boundary="===============2200788076600515838=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2b50829f1fb3dd6374d7f7a3bd10073560752f79b56029e9ab1d02e0d7febdcd@mail.kernel.org>
In-Reply-To: <20260213-bpf-xdp-meta-rxcksum-v2-3-a82c4802afbe@kernel.org>
References: <20260213-bpf-xdp-meta-rxcksum-v2-3-a82c4802afbe@kernel.org>
Subject: Re: [PATCH bpf-next v2 3/5] net: ice: Add xmo_rx_checksum callback
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org,donald.hunter@gmail.com,kuba@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,aleksander.lobakin@intel.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com,netdev@vger.kernel.org,bpf@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,lorenzo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Feb 2026 16:00:07 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FREEMAIL_CC(0.00)[cloudflare.com,vger.kernel.org,lists.osuosl.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-258635-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD2BF137C5D
X-Rspamd-Action: no action

--===============2200788076600515838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Implement xmo_rx_checksum callback in ice driver to report RX checksum
> result to the eBPF program bounded to the NIC.
> Introduce ice_get_rx_csum utility routine in order to rx cksum codebase
> available in ice_rx_csum().

This isn't a bug, but the second sentence appears to have missing words.
Should it read something like "in order to make the rx checksum code
reusable from ice_rx_csum()"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21992879200

AI-authorship-score: low
AI-authorship-explanation: Garbled commit message sentence and non-native English errors are characteristic of human authorship; AI tools typically produce grammatically correct output.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The only issue found is a garbled sentence in the commit message; no functional code regressions were identified.

--===============2200788076600515838==--

