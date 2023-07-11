Return-Path: <netdev+bounces-16666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EDC74E3A3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 03:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9646B2815C7
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93436EC1;
	Tue, 11 Jul 2023 01:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3BA50
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 01:43:58 +0000 (UTC)
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA52BDB
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:43:56 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D88EA7A0AB1
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 01:36:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 828967A10C7
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 01:36:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689039418; a=rsa-sha256;
	cv=none;
	b=a5k80MQmH9bI9ZHcHCcAq8lKlsOjPApqgCE3+rVemCar+kIwiD2kTDR8zdXbYyaXdwYCvI
	Bpsi2Dtw6t3M4WB8PCDfWkWpeq6WuCoBukEqesd+2fDc6BOut1u4n8BXcMs0/NVAgEqtM/
	qOJLndtE056dGLeW+BSphfkyiQ24dP8wnuFL2L/GbYHgoAPdouJe0QkahVazv49/ZLNrzB
	gNz5/+SRb8ouZLDmVo9RPMKZe8xQ69vfduNy77QXsisbWyzPlA3MNOQwu4+23kNIwEghII
	8y+cSDG2mXuyZvvXqkqpWSyQI4RIcidBQLpw+5SOph8U7ZKwUIrUErewm6q0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1689039418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=9C09DFYjbkA3qX/xOCH7vHdTDVOZKKI2r2CDGzvM66s=;
	b=moAaFgwcuVytf5G9hRyEtHAENX8KR0sW0pD6kNo85kxJbr8VPY9xM+9wqslGnrfBBM7AnE
	K5aRLeWudiG/B7GOZaSzWIIZyuNxs9k45yVnMxb6MPc61EaARNMyfrNqeBKfm0lYvo3W+9
	0Q6BPmUvPCwwHKUh2QSX1Oi6EoRKB9lW59qmp7dRrUBvna9gF6l/cjnpdQbwNvbH4OX6Pz
	5Hs4TmDBK7edqx2TPLztxbXJSwp/wUDSLGxi1bFtxjE1Q8X0zfavTM2bSdMTkQTWKglb6g
	XCBlADaSxuivQdROVNcBuXLhxtBhM6AaNjlN0hHsJ4gyMei+tdavJvdmt8RNyA==
ARC-Authentication-Results: i=1;
	rspamd-5595f87fc9-qjmvw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Harmony-Interest: 37f2402a7f389296_1689039418742_2264681642
X-MC-Loop-Signature: 1689039418742:2624708707
X-MC-Ingress-Time: 1689039418742
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.146.93 (trex/6.9.1);
	Tue, 11 Jul 2023 01:36:58 +0000
Received: from kmjvbox (unknown [71.198.86.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4R0NlF5b4Nzys
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1689039417;
	bh=9C09DFYjbkA3qX/xOCH7vHdTDVOZKKI2r2CDGzvM66s=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XxxE/XQ3lwRN4gW4IwCC7Rc0XyOVile4FxwTjmf2dgJ2hK7imiwXYWJE/iaIsz9dN
	 5BbsegwtyAAhzu5nF7JCfHSuL7vAD3n5PDUveGRTTbu+5PgUgzUeiX/24HlpWfjLJm
	 bZkkFqS1kOIm/U3u39HJB4c9TYJu5ooNajp/i0PM=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0085
	by kmjvbox (DragonFly Mail Agent v0.12);
	Mon, 10 Jul 2023 18:36:21 -0700
Date: Mon, 10 Jul 2023 18:36:21 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: ena: fix shift-out-of-bounds in exponential backoff
Message-ID: <20230711013621.GE1926@templeofstupid.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The ENA adapters on our instances occasionally reset.  Once recently
logged a UBSAN failure to console in the process:

  UBSAN: shift-out-of-bounds in build/linux/drivers/net/ethernet/amazon/ena/ena_com.c:540:13
  shift exponent 32 is too large for 32-bit type 'unsigned int'
  CPU: 28 PID: 70012 Comm: kworker/u72:2 Kdump: loaded not tainted 5.15.117
  Hardware name: Amazon EC2 c5d.9xlarge/, BIOS 1.0 10/16/2017
  Workqueue: ena ena_fw_reset_device [ena]
  Call Trace:
  <TASK>
  dump_stack_lvl+0x4a/0x63
  dump_stack+0x10/0x16
  ubsan_epilogue+0x9/0x36
  __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
  ? __const_udelay+0x43/0x50
  ena_delay_exponential_backoff_us.cold+0x16/0x1e [ena]
  wait_for_reset_state+0x54/0xa0 [ena]
  ena_com_dev_reset+0xc8/0x110 [ena]
  ena_down+0x3fe/0x480 [ena]
  ena_destroy_device+0xeb/0xf0 [ena]
  ena_fw_reset_device+0x30/0x50 [ena]
  process_one_work+0x22b/0x3d0
  worker_thread+0x4d/0x3f0
  ? process_one_work+0x3d0/0x3d0
  kthread+0x12a/0x150
  ? set_kthread_struct+0x50/0x50
  ret_from_fork+0x22/0x30
  </TASK>

Apparently, the reset delays are getting so large they can trigger a
UBSAN panic.

Looking at the code, the current timeout is capped at 5000us.  Using a
base value of 100us, the current code will overflow after (1<<29).  Even
at values before 32, this function wraps around, perhaps
unintentionally.

Cap the value of the exponent used for this backoff at (1<<16) which is
larger than currently necessary, but large enough to support bigger
values in the future.

Cc: stable@vger.kernel.org
Fixes: 4bb7f4cf60e3 ("net: ena: reduce driver load time")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 451c3a1b6255..633b321d7fdd 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -35,6 +35,8 @@
 
 #define ENA_REGS_ADMIN_INTR_MASK 1
 
+#define ENA_MAX_BACKOFF_DELAY_EXP 16U
+
 #define ENA_MIN_ADMIN_POLL_US 100
 
 #define ENA_MAX_ADMIN_POLL_US 5000
@@ -536,6 +538,7 @@ static int ena_com_comp_status_to_errno(struct ena_com_admin_queue *admin_queue,
 
 static void ena_delay_exponential_backoff_us(u32 exp, u32 delay_us)
 {
+	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);
 	delay_us = max_t(u32, ENA_MIN_ADMIN_POLL_US, delay_us);
 	delay_us = min_t(u32, delay_us * (1U << exp), ENA_MAX_ADMIN_POLL_US);
 	usleep_range(delay_us, 2 * delay_us);
-- 
2.25.1


