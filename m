Return-Path: <netdev+bounces-260219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GHsECrOnGnjKQQAu9opvQ
	(envelope-from <netdev+bounces-260219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:01:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EA617DEA4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1269E305EB88
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8643793B1;
	Mon, 23 Feb 2026 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CluqzD6r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F136C0DB;
	Mon, 23 Feb 2026 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883913; cv=none; b=tbX4w183YrD3NFc2IOByuX7a/l6NSavzFEHLXpdHINw5xxHaEBIGU7rTZwDA7uAfbv1udcC77UZnMb4B/ZhHdvFNR9c6ye2/7YZqY7X3fqffivei4OX1xQlwbb/hYGmt+lPmUX5EUx66+f4PiGvTF7SzoXl4KW/L2+BbRGgrhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883913; c=relaxed/simple;
	bh=LH7t0a1QDpqWxeBEQhpvu6CX5dJnL5YjXXl1tp6SK1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UY3aF4AzJq5xlnoNaGNR9/3Q37wMh/L5MGCsPX19yT4RoRQEY7Lap9oyyrDfmxDEgxfrVVgHUFB1OlJPFzcV/IXcmNW4UHMU6R7xBIfmJcs50fPlCobjozZ9dRzeX4mUg3WEs+VBr7ch3G8XBJnZCqywMRfqXXEuG5FcOQwQVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CluqzD6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F62CC116C6;
	Mon, 23 Feb 2026 21:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771883912;
	bh=LH7t0a1QDpqWxeBEQhpvu6CX5dJnL5YjXXl1tp6SK1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CluqzD6rIM4sdXWBLXxfLQYyff18qgV2UCtH2AOyPZluIzccw1gV9+iHGfc65oxPW
	 43ByX74Y8sG5h3RwoBRC+IPnD6VtwwrCxrxdz/DED/mcVExadcl8Xvr7R9nbtMTYuV
	 xbRfjZ0/QeIdYMdvVPR6Y728ZmsHxFPQJP8oWJs4MCJXf2iRP3ILhsfRfYLPN0q1fW
	 hE/LYes1mAUTtO2V09TNivE+5n638QA1sk73S8Y4AxPKRLixJ7xU5akQ70wOJIhR0e
	 OC+4/nyGLz1MX8ENHMEsyPB7zCKPhJ3C8iyxMdIQ7V85DWT/F4EPNpbzZsks7JJ+gj
	 BegTntTrjSJ8g==
Date: Mon, 23 Feb 2026 13:58:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kiran Kella <kiran.kella@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, daniel.zahka@gmail.com,
 willemb@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 akhilesh.samineni@broadcom.com
Subject: Re: [net-next, v2 2/2] selftests: drv-net: psp: add test for VLAN
 sub-interface
Message-ID: <20260223135831.102f73a4@kernel.org>
In-Reply-To: <20260223191154.2800616-3-kiran.kella@broadcom.com>
References: <20260223191154.2800616-1-kiran.kella@broadcom.com>
	<20260223191154.2800616-3-kiran.kella@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260219-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,gmail.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: C7EA617DEA4
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 11:11:54 -0800 Kiran Kella wrote:
> Add test to validate that the psp device information is propagated
> properly from the lower device to the upper devices so that
> the PSP transmit validation passes.
> 
> Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
> Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>

Looks like you need to enable VLAN in the respective config file in
ksft:

# ok 28 psp.removal_device_bi
# # Exception| Traceback (most recent call last):
# # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/net/lib/py/ksft.py", line 338, in ksft_run
# # Exception|     func(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/drivers/net/./psp.py", line 597, in vlan_basic_send
# # Exception|     ip(f"link add link {cfg.ifname} name {local_vlan_ifname} type vlan id {vlan_id}")
# # Exception|     ~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/net/lib/py/utils.py", line 238, in ip
# # Exception|     return tool('ip', args, json=json, host=host)
# # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/net/lib/py/utils.py", line 225, in tool
# # Exception|     cmd_obj = cmd(cmd_str, ns=ns, host=host)
# # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/net/lib/py/utils.py", line 91, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/net/lib/py/utils.py", line 117, in process
# # Exception|     raise CmdExitFailure("Command failed", self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Exception| CMD: ip link add link eni1972np1 name eni1972np1.100 type vlan id 100
# # Exception|   EXIT: 2
# # Exception|   STDERR: Error: Unknown device type.
-- 
pw-bot: cr

