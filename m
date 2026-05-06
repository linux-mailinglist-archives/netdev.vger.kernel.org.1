Return-Path: <netdev+bounces-285021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lm6CNCi+2mvegMAu9opvQ
	(envelope-from <netdev+bounces-285021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:21:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF40A4E01F6
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED0333009CFA
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6852346E47;
	Wed,  6 May 2026 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K34bdA0x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9031E831
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098891; cv=pass; b=X+l743MqNOOFOGkTBBTjPi8BH66eRllwJ62m76m0sWzahxLXVibdSm+8X7wbny4My3rIR29gdZCWatavEncmEMmyJj2UvUO09dZ7OYVz+G+FHKFAZ8C+UhBpTy+t4nw/9bkK+YwA2rmyMQdarvRTK2O0LQjPgAxb+7BjUjCfhWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098891; c=relaxed/simple;
	bh=QAqsL+P/EADi7i+Ad2gryAbkt9BAPf51xGRCB34VjX8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iaTZ5CwcFPBi+KZCYPZaS9Mx/4QsngyALjRR7DY0E3ltF+wcJqIWhMgfzI3ZBtOWuIwSnGINBxRqULh0FGiQy/LCQEdAqWKd6dQNlTNyi6svg+C/YWnIUAAdXoHIKsxUDtzlY4w8DEvtyaDBl47PE9A5XO0WCkE24Hd7AYwIDjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K34bdA0x; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bb0d18c7f9so700047b3.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 13:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778098889; cv=none;
        d=google.com; s=arc-20240605;
        b=R5vORGK4FdOMUz2olaaQERlsXumoJsevQcSg6i4BHzU21hgNHyDlCLQyRYgyhsExEq
         Sz+TtEbHDGnNnYTToXIa5elDpWz+IdQ25ipg7vp5WeJQJC2FH0B6C3Mj2uFN1+DBaGZK
         03VuUpY+knVs+LdRhcHdhcQkZxH33KCHybpqkasrZfDUnIkGMfB4Z0RIrU+IJSiL5xmh
         rySbqXkNrRqnUR8fNmKE5Vhj4W+0hCfh9TXnHlE1foGEGOifFS4AYikxQCwaD+L/3veS
         7pnBWQxCkJQaMDpca4rDthT+TLOD23zwxWp+8Gfp9dMx+q8jVkeRo0RhDHjcp7TI8avj
         9C2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QAqsL+P/EADi7i+Ad2gryAbkt9BAPf51xGRCB34VjX8=;
        fh=dcVxwJA/j6dv2elbHLlvH74hf1891TMHOuctm5VwxCQ=;
        b=Rc/pqs5U+eWh0JWwyEGUe0gu9BjQSxAALoRWy59dhR24105Bs5axMG4VZ8vmAFn2SI
         Mwj26ygymjR2HvlABYyGjyVexMFV9JvM+4Gb75yACeOokyiNCAATe+uFdWkLbDDOUq+H
         xOVxurL66rVwLYvURxCNxVlIpseblL1EByunsXdZ/S+KT3YqXXRTJn+C9Xxg1IMApqir
         cRnxvZ1LZorPe/yFp5lEcIvC1rRVWDNbHYTrxt/vYdAAGISqvbddR3bKZcMTtwm4ijey
         PYcbC/Ssfmz7Gnpo7MQ2Wckr90l9gxadeJ7XrpdSx1Bp3tgawPx3/3OgiKgM3tOjrnJL
         jHsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778098889; x=1778703689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QAqsL+P/EADi7i+Ad2gryAbkt9BAPf51xGRCB34VjX8=;
        b=K34bdA0xZfjembZQ0UZFzUqgKEfqLXMDfVZciVNVIK/sgWYAsedwcOTRB2pXOoNmrR
         wTQZUHuIQLxrtIUDo/ZX0d6Up62i9gXC3oQGiaTtG7N/Ne5jYbLM6PkKs7iREEF4+KvQ
         qVNrIzPztwnxlY55D7wNHFkNCQDsSoMNBhaCf0Htfl2EOUiWcOlPTYFIQVcHXgMaCE84
         GtsNWn7QhNBdQ/LKnFirEPDRlbCfYZMBCvvMGZkiF3K0yAlHyFtwmzeCKKYowRbzp4if
         jsqUeZFEt6A1o+C0TdgTJYnm4rTWy9qcGt0+Ilpd09Yh3aSkYsLyRDyPT/jfJTzl84W4
         SjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778098889; x=1778703689;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAqsL+P/EADi7i+Ad2gryAbkt9BAPf51xGRCB34VjX8=;
        b=I394qHbS79MsC9809812jHVjs/fvLqYrOLR0hom1FrDPoe+t11ARnIUCuYtS54nDzp
         eEo34iDBmA40WAOiidC0qlN7MRcPtFsBY56mwfyaqHH8Q8g/jFO0QocpF2vquRaaxdjk
         mNSSAgzO8H+ICWHk9mssotJfVfpqCjXW8dEc1sRAOO+q20uZ/f7PfYy8nTMS7aT/GMAB
         QwkSH53ShIshdWrlo06yNi1oZmM7w2aXbRUxW9hHB8XKhNh63ot6D8WxIXoIXrcHNdht
         +0bkQkI0YssHO/JwprWYFLtlCYSXdGjL8dskRfYiimwsy8GgvuhSO7UgxWACueM0VQCe
         zU+w==
X-Gm-Message-State: AOJu0Yz6pHCIVVN4wolSDJpyj52zFWNPDXQYR2yRTSwHUy3uGw+W+tjO
	2K+z8HWd6W/0ToyZRWpyBGrjRPufc+viGQmx2PioXHh82FoR1LGv3tVjUNcZmkJc/+0WbFtDV5N
	Eg6ayWlUEpcyYOYxksMBqtuq7JZs8KkMLdxWtaXA=
X-Gm-Gg: AeBDieus619joL7/pG6irwHoMAryc8trg0Z2CIlfyWgYZ9mL8+1YHy4x+Q5gN3JDF0m
	MyLYoHDonGcgOvPqUYw7/efA0i9L+EspHjM49Gc6+Jz4rAISGp5NcjLToVuW5ph2ZmBzyY0uV7F
	72onoTXXEewV1c8Svjt9vOfXGOS9JdWzThKfJRjkLmU6vCqIpxeo9ZWBLdotJMpVK21AuAz76/T
	xgC7VXi6AbfxhoUQluyFxn5BeMxn7Ng5y3h4wrtgTEkh1QBnWnRvehOxhmM+OVjTAsKjBUrgpG0
	74/KhU+QnJBISqyAwAYw0M/Tg48a/10=
X-Received: by 2002:a05:690c:92:b0:7bd:8752:cdc7 with SMTP id
 00721157ae682-7bdf5ed03edmr57314817b3.39.1778098889546; Wed, 06 May 2026
 13:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jorge Mayorga <mayorvlf@gmail.com>
Date: Wed, 6 May 2026 14:21:17 -0600
X-Gm-Features: AVHnY4KmODo-emmWNrM3WYgqpixKknjVjoIsDpk2RHha45bWNLj5eq5bXX3aMmM
Message-ID: <CAGK_M0RWxDBY4CP-M9PxMf2codLim-xXdZ4BH158vW+FTq+8Ng@mail.gmail.com>
Subject: [BUG] EM9293 PCIe (MHI) WWAN RX path broken on kernel 7.0
To: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AF40A4E01F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285021-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mayorvlf@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello, We are observing a data-plane failure with a PCIe-based WWAN
modem (Sierra Wireless EM9293) using the MHI subsystem on Linux kernel
7.0. Environment: Kernel: 7.0.0-15-generic OS: Ubuntu 26.04
ModemManager: 1.25.95 Modem: Sierra Wireless EM9293 Bus: PCIe (MHI)
Driver: mhi_net, mhi-pci-generic Issue summary: Two distinct failure
modes depending on protocol: 1. MBIM mode Interface created: mhi_hwip0
State: UP, LOWER_UP, POINTOPOINT, NOARP IP assigned correctly Traffic:
TX packets increase normally RX packets remain near zero Ping: 100%
packet loss Counters: TX: ~15000 packets RX: ~7 packets This indicates
TX path is functional but RX path is not working. 2. QMI multiplexed
mode Interface qmapmux0.0 is created Traffic works briefly Interface
is removed shortly after connection Interpretation: MBIM: control
plane OK TX OK RX not functional QMI: data path partially works netdev
lifecycle unstable Low-level interpretation: TX path: host -> mhi_net
-> modem OK RX path: modem -> mhi_net -> host FAIL Additional
observations: No routing issues No firewall interference No userspace
misconfiguration Same failure persists regardless of routing setup USB
(cdc_mbim) works correctly on same hardware This appears to be a
kernel-level issue in the MHI WWAN data path. Likely areas: mhi_net RX
handling downlink channel setup rmnet/qmap lifecycle possible race
condition in netdev teardown Request: Any guidance on debugging the RX
path in mhi_net would be appreciated. Also confirming whether current
MHI WWAN support is expected to fully support RX on PCIe devices like
EM9293. Thanks

