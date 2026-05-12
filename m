Return-Path: <netdev+bounces-287259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEkbJJFrA2rF5gEAu9opvQ
	(envelope-from <netdev+bounces-287259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:04:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8E0526A66
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0265305A22F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E83C0A05;
	Tue, 12 May 2026 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGcV0a7J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5E3955DC;
	Tue, 12 May 2026 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608263; cv=none; b=C7wM875Mb86Eo29NI9wxZNj5Jv9sCrFWedIP0tttEr7jpkmwCj3Ux51gdm0Mmf98kgwUkUEb2HUWd+ygABwXAEwQhbkRv4vjtB+jmtfJRuFnYfx//kMXbn6yD4NiEGTXc2uSQCAXbBHm1i+o5SDP5ERiU+5tbLX85gAM2bm/owM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608263; c=relaxed/simple;
	bh=OB76pSjC4cP4rcVH6GCZbTKO975jwLyfmmcSR3anRnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zot3N71eCMZR7F3HhCRR0CR8FOI/W0qOcSV5aWu28pSO6KGFZmoWuVxQ9GrRFcKL6gh0xt10LIVIWFLr18N3bZWMlNGuUFRaB2yzuq8ZWxGI2qiIk0pWoSlHNhfm9/CdlBThGXcxYkyriWftuBeb4uWLFHBWfuTTK+LmpIm7d8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGcV0a7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8C9C2BCB0;
	Tue, 12 May 2026 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778608263;
	bh=OB76pSjC4cP4rcVH6GCZbTKO975jwLyfmmcSR3anRnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qGcV0a7JVrsSOG1D9GZI+vsJaM7qIGuF7YLhkKRrhPMRINLqQJgKPJ70cwQw9sK+V
	 nvdm59+cVU5D7D/dFygICvD4NC5z54WM4JHThwfVEIcxb6+VK+49vq9nBSbVnN3fkb
	 A2+EH1+Rmmo3dMiCrVTgudYZBiTKk9n/gqEFjhHdVsFZHrujHshtQP/X+P1jjN40qK
	 mHd8cueGz8p/zLIWnYmoFTTBSHvBCKrNCwnpc+4+dnteH7p+iMkT0CFk2YA1VPtjKX
	 glAsuh9oGVoQDmvQx1dVUhtVc3lOvdPoQtx1cL74ApV6w+CEVvGVv3Ms8UMdZfppWR
	 IvvBzdivcQZpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CDD3812FD7;
	Tue, 12 May 2026 17:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] net: convert remaining bluetooth socket
 families to getsockopt_iter
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177860820955.3015105.9745941365552490675.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 17:50:09 +0000
References: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
In-Reply-To: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
X-Rspamd-Queue-Id: AD8E0526A66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287259-lists,netdev=lfdr.de,bluetooth];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 May 2026 03:41:45 -0700 you wrote:
> Continue the conversion to .getsockopt_iter for the Bluetooth socket
> families: hci_sock, ISO, RFCOMM, SCO and L2CAP. The first patch is a
> small precursor that fixes a long-standing 1-byte put_user write in
> hci_sock_getsockopt_old() so the subsequent conversion stays mechanical.
> 
> The riskiest change in this series is the SCO BT_CODEC conversion: it
> is the only one that drops an open-coded ptr cursor in favour of
> relying on iter_out advancing naturally on every copy_to_iter() call.
> Every other socket option is a near-mechanical s/copy_to_user/
> copy_to_iter/ rewrite, but BT_CODEC walks a variable-length list of
> codecs + capabilities and previously tracked its own write offset by
> hand. Getting the cursor semantics wrong here would silently truncate
> or misalign user-visible codec data.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] Bluetooth: hci_sock: write the full optval for getsockopt
    https://git.kernel.org/bluetooth/bluetooth-next/c/375386737970
  - [net-next,2/7] Bluetooth: hci_sock: convert to getsockopt_iter
    https://git.kernel.org/bluetooth/bluetooth-next/c/317bb006946a
  - [net-next,3/7] Bluetooth: ISO: convert to getsockopt_iter
    https://git.kernel.org/bluetooth/bluetooth-next/c/2b650bf299b6
  - [net-next,4/7] Bluetooth: RFCOMM: convert to getsockopt_iter
    https://git.kernel.org/bluetooth/bluetooth-next/c/477cbdca7568
  - [net-next,5/7] Bluetooth: L2CAP: convert to getsockopt_iter
    https://git.kernel.org/bluetooth/bluetooth-next/c/fcadc2780bf2
  - [net-next,6/7] selftests: net: getsockopt_iter: cover SCO BT_CODEC conversion
    (no matching commit)
  - [net-next,7/7] Bluetooth: SCO: convert to getsockopt_iter
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff2e1268ee45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



