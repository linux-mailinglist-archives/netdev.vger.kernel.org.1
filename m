Return-Path: <netdev+bounces-23064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB476A8E7
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC451C20DD3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317FD4A15;
	Tue,  1 Aug 2023 06:22:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405F4C8C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5CFC4339A;
	Tue,  1 Aug 2023 06:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690870970;
	bh=kuEWnL9p9BoO9qyiypu88WnOmaK1A5r5Av53wC58X/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTAaCdjqqtaGw4jXqE8Zp1B4A46QbjBp0dXr631H/PgNlLVBuyCklYAGke2Wh0SrB
	 V3LiY5YC3HRiuHhVcgPq7e69TY1EfVP0ql+l85qpEBSMzhf5uQV4tFTSYFr0fOcbD8
	 YijqLZynDBoU/TqXA6ioHSRUf0zg2cPEPkzDJ9f3wj9kVA8/uPOlBzgCkQGQN9i6Pw
	 MPgq4IbGoM20r5r/j6iwS46RTzkeZJdGrcnUb/gBr559dRO7FmwyUfLNRKW9oHmcfA
	 G8TOEodJKvNN7nvplCEH4mTmHxXpQvq9abVmp9aoVl+hf+yq/awLxqUl2ijo8ewb5h
	 wIgfwLXTr1gpA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Max Staudt <max@enpas.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] net: nfc: remove casts from tty->disc_data
Date: Tue,  1 Aug 2023 08:22:37 +0200
Message-ID: <20230801062237.2687-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801062237.2687-1-jirislaby@kernel.org>
References: <20230801062237.2687-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty->disc_data is 'void *', so there is no need to cast from that.
Therefore remove the casts and assign the pointer directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Max Staudt <max@enpas.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 net/nfc/nci/uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index cc8fa9e36159..082f94be0996 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -172,7 +172,7 @@ static int nci_uart_tty_open(struct tty_struct *tty)
  */
 static void nci_uart_tty_close(struct tty_struct *tty)
 {
-	struct nci_uart *nu = (void *)tty->disc_data;
+	struct nci_uart *nu = tty->disc_data;
 
 	/* Detach from the tty */
 	tty->disc_data = NULL;
@@ -204,7 +204,7 @@ static void nci_uart_tty_close(struct tty_struct *tty)
  */
 static void nci_uart_tty_wakeup(struct tty_struct *tty)
 {
-	struct nci_uart *nu = (void *)tty->disc_data;
+	struct nci_uart *nu = tty->disc_data;
 
 	if (!nu)
 		return;
@@ -298,7 +298,7 @@ static int nci_uart_default_recv_buf(struct nci_uart *nu, const u8 *data,
 static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 				 const char *flags, int count)
 {
-	struct nci_uart *nu = (void *)tty->disc_data;
+	struct nci_uart *nu = tty->disc_data;
 
 	if (!nu || tty != nu->tty)
 		return;
@@ -325,7 +325,7 @@ static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 static int nci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 			      unsigned long arg)
 {
-	struct nci_uart *nu = (void *)tty->disc_data;
+	struct nci_uart *nu = tty->disc_data;
 	int err = 0;
 
 	switch (cmd) {
-- 
2.41.0


