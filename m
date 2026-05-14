Return-Path: <netdev+bounces-287965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OBzDdDQBWoPbwIAu9opvQ
	(envelope-from <netdev+bounces-287965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:40:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1DE5426E6
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB4F3017791
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17163E0C4A;
	Thu, 14 May 2026 13:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86FC3E4C70
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765976; cv=none; b=W3MPqe0V4Uc/KVPfOz8nAhBT/vmQLcB+VQ9oLxDDY0/DbewTY28l9omL3wykGM5Y2tOyzLbEX+v/mBkqKyhWJ1uOVf8967relc8IWTaejCuL698M/kYlUG98wgaHp+ykYskTngxv5n3uzk5i6DAm0PLT9QnDCl2O0Z2ALUh+Vxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765976; c=relaxed/simple;
	bh=68A8qumFQBQ9MtT1CV1OR6pY9cZWxVL93bkySL9cgmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rp03m3WznYHHqrQrq8RmFilWN2RimLWNipGUX4AsIGAfe83kqW6rZcvktaSrux3B5nTAxFe9dVhIaZ2fOgE3XY2rsMaFZ3jSGhA5XsyKXiG1S9GCC70ye5uCinODsVAqpG92zoWZR2GLNUXk+y64xW4XxpQyZSdz6K/Sz7tlZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64EDd8hh006290;
	Thu, 14 May 2026 22:39:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64EDd8T8006285
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 14 May 2026 22:39:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <04ca05e8-de5b-4c2e-941d-fde0c348293f@I-love.SAKURA.ne.jp>
Date: Thu, 14 May 2026 22:39:05 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: addrconf: skip autoconf on unregistering
 devices
To: Xu Rao <raoxu@uniontech.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        horms@kernel.org, idosch@nvidia.com, kuba@kernel.org,
        kuniyu@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com,
        willemb@google.com
References: <260a0064-0fa2-40cc-bb8c-1ee29f12dd1d@I-love.SAKURA.ne.jp>
 <B2E03D908A12A79A+20260514131854.1752183-1-raoxu@uniontech.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <B2E03D908A12A79A+20260514131854.1752183-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp
X-Rspamd-Queue-Id: 6A1DE5426E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287965-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e2af46126e0644cbebdd];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[I-love.SAKURA.ne.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 2026/05/14 22:18, Xu Rao wrote:
> So the no-patch baseline still triggers the leak in the same environment
> where both the proposed patch and the WARN_ON() diagnostic patch returned
> OK.
> 
> I agree that the WARN_ON() result does not prove the exact
> NETREG_UNREGISTERING hypothesis, because it did not trigger.  I also do
> not think this negative result is strong enough to disprove the race:
> this bug is timing-sensitive, and even adding the reg_state load, branch
> and WARN_ON() site can perturb the execution enough for a best-effort
> syzbot run not to hit the same interleaving.

Since easily reproducible cases have been fixed in
"unregister_netdevice: waiting for DEV to become free (8)",
cases reported in
"unregister_netdevice: waiting for DEV to become free (9)" and
afterwards are likely timing-dependent difficult-to-reproduce races.

Therefore, we need careful reasoning for why a patch can fix the problem.
Carrying my debug printk() patches in networking trees might help.


