Return-Path: <netdev+bounces-265696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCBJLMETr2nJNQIAu9opvQ
	(envelope-from <netdev+bounces-265696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:38:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5453023EB53
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8A6C30101DF
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87825396D2B;
	Mon,  9 Mar 2026 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD1mKNXx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CB36A03B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081534; cv=none; b=HW0OQrN8FXSMFr4sqJnxNL252kEXiD5f+EnUiJQPTuiCBhKy2i1xq5mMKYII4B9xmYv/NTr630ul/DTpweZnD9daIsHwvLhLt4ise4aADWWhKOEq3QTqmE41Q8uvroP+E6X43tcTyTDyFbJlLnVQZXxEhBh1F/8LW32fs98aX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081534; c=relaxed/simple;
	bh=u9PZ/S/J6TXY5p5L9CZM80gR87hsjsurTArWYLMzZNE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pvSxG0+owOr7jb0pCxGOP+HSJhFDp4+NBJS65DE6kZ8iEiIEGVmfU9zh1/yUJ1acXexSuUM3rNhYtMReJX/DJuAGomiqlbjHrU/DT4b+V7BNkZo6+5HFl3cPh1WoPCsv2zwGgA/BRKSuR9CoBeWdI6e0l67QAvNX5FCyURc7Stw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD1mKNXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D566AC4CEF7;
	Mon,  9 Mar 2026 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773081534;
	bh=u9PZ/S/J6TXY5p5L9CZM80gR87hsjsurTArWYLMzZNE=;
	h=Date:From:To:Cc:Subject:From;
	b=JD1mKNXxHKbnH3PoJgkfogSbXgLldv9lQhCMN3tdBW+03jBO2TQQij7YFBZl7Mo96
	 eDU3OGUZjYsYiaKiGG+liw2loJSPaKAfujILTYnTX2CKSnObvrlQsnEvCt21FXbQtn
	 KN993sMAL1eauBoHRbYkwah7grntVkJtHRr6D8a+2a3anJeDNXlc0Ff8BeY053/RS5
	 QBNiWqTQi2BP792zSy8mDrNDnIBay3lS8TesXIHrVSVJ9TuHiLcUfbpXUJ9Qb2tw14
	 W+W0HURhUkP0V02IQDWGtwUI4NbgKvaZTDiqv+jZNNeXEw9E0pE8CrlyvZtbRSUFFp
	 v3Smourcad0og==
Date: Mon, 9 Mar 2026 11:38:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Zinc Lim <zinclim@meta.com>, almasrymina@google.com, willemb@google.com
Subject: fbnic qemu is open source
Message-ID: <20260309113852.2c654de5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5453023EB53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265696-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi!

The fbnic QEMU repo is now open source and available at:

https://github.com/facebook/fbnic_qemu

It contains the emulated datapath for the fbnic device, the FW
components are not included (PHY programming, NC-SI, init, sensors 
and such). 

The main practical use I imagine is being able to test TCP Rx zero
copy (kernel and/or user space) without any HW dependency.
There's work on adding relevant features to virtio but it's going 
a little slowly. Also being able to test code and selftests with 
a more "real" device than netdevsim with vng is super convenient :)

Big thanks to Zinc Lim for the open source heavy lifting (isolating 
and mocking out the FW parts, cleaning up the code base and getting 
it thru corporate reviews).

No plans at this stage to upstream it to QEMU because TBH I don't
expect that QEMU would care to carry random HW emulation drivers.

Sorry if the announcement is a bit self-serving but folks expressed
interest off list in being able to test the queue API and zero-copy 
Rx without real HW so I thought it's relevant.

