Return-Path: <netdev+bounces-279247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEGdL+bb4WkXzAAAu9opvQ
	(envelope-from <netdev+bounces-279247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:06:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B0417A75
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2AC5302C928
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 07:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B193254A0;
	Fri, 17 Apr 2026 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFc0iIO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A431F9B9
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776409282; cv=pass; b=dMCMoNATXiAhBLuu3wyKb8QVlDRjH1o2sC4NlfEugX97eGNMhxamszgb5U9+O7iwQ3w7VXk20uOyh/LkuUgjasizeBBiD1TRUGeQRgALDhE8bQwszHmy+R14+jKMpdlZgO0Ph4LSetgglKmRBDo1Y9RAciD74SO83HmhD1GznRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776409282; c=relaxed/simple;
	bh=CqEfDEULqCUK0Xs6W590UUKHGlvposw/hPiDYEQNGFI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IsQssFR1U23+mFkcx+7KJPE6L3BxXcs5YGPHj26A/Ksan7OVHroPZ9DgWILtcnbZrITrmskG8bzIAsgbLOiBDWgjnsvrI5ndsJ8FyUk+Sj/E1NJrH4yX7n8W5qgOytmUNtQxWn0yrFri9N/DDy7WlOaIo5gOiug7mOaKm2cU3ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFc0iIO1; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-94de664b541so76035241.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 00:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776409280; cv=none;
        d=google.com; s=arc-20240605;
        b=NU8Q5Gfk3kUWwri+hO4NA2cI0u5Y2T2qACxtEHAz2nWdp1MdQiPKbNGDNg/2dKXAra
         SoATaZujrBFbwg1vMCL2lQwlW75p7P5j1+aJYj4h5H+trWC5newQMqdwMiKZB4d5GB8E
         hzHTXMB3U7YE3ql0SRQppbn6WMkbstbSo7J5yZjm6/bvMzc0clZrcrImgi7KW3/pgmS0
         iLJ7QZWFkncETjHCOmbbYlED/tDSgKye+O9HPMFXcJT3OT0FZu+9HXUl7ddKtJni2PfB
         /uZQpjKFpWEBqHD9Q3uil5KhScEFumuUP76QRK7voo/j5xEoLlj6I2Uey6GgnoqGagd5
         Xx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=L/UaHskfSyg0E4oE6Z4pYmSOvjeGIm6HpWCOupmCDW0=;
        fh=N16f6VWqN+9nXH3lJ3qEP+Wl+cS9hwLuZCXuQFK4EZw=;
        b=ZKP21ScDAvV0W7Ix5h/yELg6plZ2ujicObigIiqjNN9QyZhoDgYzUSvuPLnr1k5ftA
         OEn/ulAZ1IxdizfXZfcJNwa6SRgTBLevUH0Ln8hNmXn+MD0dJa6LDiObDaRpS8I+rpDN
         fLEHJhN1qW7X10Kj3Tr3K2EeYlQOtVDSKXYFdVDqcp+2AbkZWxUaLIkry7hyejqkxux0
         hIS+8DZPqVUvbtToi8eURYDXpUxBHf+H2KbvZWgkSoTSuOnZV+5BWT2Tnvb3O67VxoOJ
         INoZcz9ZNPAIOkoIsgowTmSPbOzBtUyp5yPAHwNbJo5MrqPjt7ycLkEu7GTN4Tpn67nv
         YwnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776409280; x=1777014080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L/UaHskfSyg0E4oE6Z4pYmSOvjeGIm6HpWCOupmCDW0=;
        b=nFc0iIO1k7ULPnN9hYpsrbq0ryOvT4I0HN2BTxeMjgd4c4gg+NB3GxIYsJ/pKZybJE
         /ySI0EDrDSrc/ge0aue9/8tomTQnbIVEGPzopm37Hp0cwkPl76dkRzXdzSIb6gs2l1Ol
         VRa/CM2bpwkasURSR07QF5idNUi7/FdVVl8IXpnYiWiE3PZm88XsHxx+OyQi54p60sq8
         XTyGSBh9YbdcFxwCyX1muTi9jyFfaKa78odfBDmaIty1ZsTzkp1M/zgam+D+RkbmigAB
         NAbCUbyX1YR2Je0rkuxaS15GtcI1GybTkFpb2KCSz4jxvb1ykYcFxtOatblwZuO/mUFL
         ++rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776409280; x=1777014080;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/UaHskfSyg0E4oE6Z4pYmSOvjeGIm6HpWCOupmCDW0=;
        b=bOU2ORbBgZ9wR24iWdS+Kc/usel9fjJvm8TW0dVhmIqrUbrf6RdNNOkDMnaUcNgdfV
         XMx/D1qDgT9IDAgHSbBMas6hczZR+bh6ihdxHblybmlw0B27RAdXYGVee7xpLzDNN/m3
         C3wj7drJBjJ2c8YElgf6PFQu+L5HIUkFu+KQtqb3sXgHEhNTOVoEanhoisi7XwOPXU0h
         w0ma+8GGSpCXGTqDK+94bTPyjir4qqwHVPfQLsFKO+RvrSgWNNe7GgV0S1fRtDmjB0+E
         Ok8/h1w+2eXg0zcsePJbTYAC/DpIVmhuzIRiGucLALbEjUSz0fzHNFV7zrAoHNL3COeV
         IBLw==
X-Gm-Message-State: AOJu0Yx33u4OJfm7zm99VnCfJQ2adY9E/a+zRBSPA/CXKCrwy4Y+znxN
	PaPHdJ2pDB7M33qpxy+qZdqzuiVPlXl8vUFUzZdqYgRXkXn2XACCzS+UiUrw3d79rLhijIqIWPw
	GlpU27RtHluN6xc5uJr9+SD8IiVdL0m0=
X-Gm-Gg: AeBDieuOlczubkIFgpRUWEecXfmiiRIx9T1EYoe+CZPrPQBVFWa7fxV21osTTZ56J99
	7qhGZ3/SQYgMqbI2oW0AMOtSOnDVtbBYSVM8YyUCJysxQ1U3IBPpaXChivqngMlRhMBOjjqNmeY
	UZAjvgEMSFHupZjDTJj0UxG3MOUrbtP409uf7HbT3xy/MIX5FsWmeoYic4bN3GMtdLW0BwqipgV
	hRPtx3EwoagOZfjKdGFwN39KC/OsReftVChQ0b8QPZVkPVEuIapXP8Cwguj1XuHOX30i/KZpglA
	QOMAxPcKZoaAT0sP+Q==
X-Received: by 2002:a05:6102:6f06:b0:5ff:ea33:2be with SMTP id
 ada2fe7eead31-616f68d36ecmr453833137.19.1776409280004; Fri, 17 Apr 2026
 00:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: plantegg ren <renxijun@gmail.com>
Date: Fri, 17 Apr 2026 15:01:08 +0800
X-Gm-Features: AQROBzBiRMFumQRyduGZZ6JGrBV0rqOHeZdeeOLP-uOsgf1OR3RDDCfLstKe5cY
Message-ID: <CAMrUUotdnC+Gv3oud75Ns3BMiOCEo+_fNYX4_L=r=YhtyzZ0Qw@mail.gmail.com>
Subject: Re: TCP default settings (bugzilla)
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279247-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[renxijun@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 557B0417A75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

One more real-world data point that just happened two weeks ago,
directly related to tcp_keepalive_time.

AWS recently rolled out Nitro V6 (8th-gen EC2 instances) which reduced
the ENI connection tracking timeout from 432000 seconds (5 days) to
just 350 seconds:

  https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html

Our MySQL/HikariCP connection pools started seeing intermittent timeout
errors every 20-30 minutes after migrating to 8th-gen instances. We
captured packets on both client and server simultaneously. Here is what
we found on a single connection (idle for 818 seconds, well past the
350-second ENI timeout):

Server side -- MySQL receives the request and sends responses normally:

  #270  71.51s  10.23.99.71 -> 172.20.64.240  [ACK]     last activity
                  ~~~ connection idle for 818 seconds ~~~
  #271 889.94s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  client
request arrives
  #272 889.94s  172.20.64.240 -> 10.23.99.71  [PSH,ACK] len=11 server
responds OK
  #275 890.15s  172.20.64.240 -> 10.23.99.71  [PSH,ACK] len=11 server
retransmits
  #278 890.59s  172.20.64.240 -> 10.23.99.71  [PSH,ACK] len=11 server
retransmits
  #281 891.02s  172.20.64.240 -> 10.23.99.71  [PSH,ACK] len=11 server
retransmits
    ... (server keeps retransmitting, client never ACKs)

Client side -- sends request, but NEVER receives any server response:

  #267  71.51s  10.23.99.71 -> 172.20.64.240  [ACK]     last activity
                  ~~~ connection idle for 818 seconds ~~~
  #268 889.94s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  sends request
  #269 890.15s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  retransmit 1
  #270 890.37s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  retransmit 2
  #271 890.79s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  retransmit 3
  #272 891.65s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  retransmit 4
  #273 893.38s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  retransmit 5
  #274 894.94s  10.23.99.71 -> 172.20.64.240  [FIN,ACK]         gives up

  Zero packets from 172.20.64.240 after the idle gap. Zero RSTs.

The ENI silently drops all inbound packets (server -> client) because
the connection tracking entry expired after 350 seconds. Outbound
packets (client -> server) still pass through, so the server receives
the request and responds -- but its responses are black-holed by the
ENI. No RST is sent, so both sides are completely unaware.

If tcp_keepalive_time were lower than 350 seconds, the keepalive probes
would have kept the ENI tracking entry alive, and none of this would
have happened.

The trend is clear -- middlebox idle timeouts are getting shorter (AWS
went from 432000s to 350s overnight), while tcp_keepalive_time has
stayed at 7200 seconds for decades. The gap is widening.

Xijun

