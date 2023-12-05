Return-Path: <netdev+bounces-53958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA4880567C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF8828199A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60235E0C6;
	Tue,  5 Dec 2023 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="kk/c92qZ"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 05:50:42 PST
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d203])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947A41AB
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 05:50:42 -0800 (PST)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward203b.mail.yandex.net (Yandex) with ESMTP id 52BF863BA2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 16:43:17 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:440b:0:640:fa3a:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTP id 11DC6608F8
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 16:43:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Bhb61x0oDSw0-Yiua0HLY;
	Tue, 05 Dec 2023 16:43:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1701783791; bh=k8apobDElm3zwlG5gL4Hg2cXeCbkRLw0CegvHiB3F+k=;
	h=Subject:From:To:Date:Message-ID;
	b=kk/c92qZUCWY2xlm2m1spPt5SG2lEnJ20OJNH1RI3wJgIGuGdv8EI26TYQ7ej+WBS
	 k5qQkj1bOuNWI+1baYuf6DT25PCFzWq4UatTHj4Hum6V3T8sdgpQ0ofeTs7acuTQGH
	 RRRmZx7ENIFbr8SZ75puF3im1DmG9G/GVqFTEb20=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <fc5a379f-80ad-46d0-b584-0a2e1684978b@ya.ru>
Date: Tue, 5 Dec 2023 16:43:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: WGH <da-wgh@ya.ru>
Subject: IPv6 privacy extensions addresses are re-applied when network cable
 is unplugged
Autocrypt: addr=wgh@torlan.ru; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Originally discovered with systemd-networkd, and requested to be reported upstream there: https://github.com/systemd/systemd/issues/29701

These reproduction steps mention systemd-networkd, but I think it should be possible to reproduce it without it.

1. Have network with IPv6PrivacyExtensions=yes (corresponds to use_tempaddr).
2. Plug network cable.
3. Unplug network cable (putting the link down isn't sufficient, only unplugging the cable reproduces the issue)

What happens is the temporary address will be removed and immediately re-added, and will linger on the interface even though it has no cable attached.

I've debugged the issue a bit, I think the problem is as follows:

* the kernel removes the temporary address
* systemd-networkd removes the addresses it configured itself (EUI64 stable address)
* when removing said address, the kernel notices it has no temporary address configured, and re-adds it back, somehow missing the interface has no carrier anymore

Here's the kernel stack trace when address is re-added (|bpftrace -e 'kprobe:ipv6_add_addr { printf("%s\n%s\n", comm, kstack); }'|):

  systemd-network

         ipv6_add_addr+1
         ipv6_create_tempaddr.isra.0+686
         addrconf_verify_rtnl+1200
         inet6_addr_del+235
         inet6_rtm_deladdr+182
         rtnetlink_rcv_msg+355
         netlink_rcv_skb+87
         netlink_unicast+572
         netlink_sendmsg+585
         sock_sendmsg+149
         __sys_sendto+267
         __x64_sys_sendto+32
         do_syscall_64+58
         entry_SYSCALL_64_after_hwframe+9


