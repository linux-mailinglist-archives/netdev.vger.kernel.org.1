Return-Path: <netdev+bounces-270995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJaRKV1vwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:02:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD85306F39
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 339943053CEB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23EB3E0231;
	Tue, 24 Mar 2026 10:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6613E3DAE
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349727; cv=none; b=Q7EV5hFXxQNE/TQR84y/NlJy+07vqLj8geWeJKmz4U4HLKYjFPg+PopH9tw14NM4OwrKUd6vGpsZ2T9H/N1mg3jGD9LeM7oR8oIiYmXPCaswmDapTic2zndo1065ziUWIt3W0R5Rez9qNOkYNWX81fsyTew9k0D4asdtKGgEf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349727; c=relaxed/simple;
	bh=qcCZ95COiv96VvpYadORWAQhY14UQvlQK48ncT/J/F8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Q3PtNJheJAqtdcwiLyDHdZMB2y9BwFUlPdbPpncwGNiVYrSdrrNwoAcnYEuOAl7g0a32UVRWbEdy6E6bMSakNlVBsCpcDJspRSf7skUvd8Bqq19itPskKAD5ySJJ3IYkDL+j8yY8ocNzzMTCp7lnct1T59DY2wdpZWpTUaLrZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62OAtJnQ083324
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:55:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62OAtJbN083317
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:55:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e0c7030b-261c-4ed1-b6b0-bf3b83a41d60@I-love.SAKURA.ne.jp>
Date: Tue, 24 Mar 2026 19:55:18 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Can networking trees carry temporary patches?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270995-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 6AD85306F39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I was carrying debug printk() patches [1][2] in linux-next tree via my tree
in order to debug "unregister_netdevice: waiting for DEV to become free"
problem [3].

While these patches had been a lot helpful, now that easily reproducible cases
has been fixed, this problem is hardly reproduced in linux-next tree recently;
giving me no hints for debugging remaining cases. However, this problem is still
reproduced in networking trees.

Therefore, I appreciate if networking trees can carry temporary patches
(patches which are not intended to be merged into the linux.git tree).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=58b4f8f612187b0d9583b5549044734ecd7071eb
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=02fb7fbf5db47bf5c1736b692888232f5f6bf80e
[3] https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84

