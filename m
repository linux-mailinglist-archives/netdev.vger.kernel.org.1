Return-Path: <netdev+bounces-18171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08A3755A26
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097AE2812F5
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 03:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C31B4C9B;
	Mon, 17 Jul 2023 03:43:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F423D0
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 03:43:05 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF81A7
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 20:43:04 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R47Fx2FMhzBHXlG
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:43:01 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689565381; x=1692157382; bh=/7krcvMT1smBctXUrn+65cydTRs
	81mX1rdV/FZXmGpI=; b=nnFBk5V/dKdC+wlpUMlPVLg5pWPyvj1/md5Gh//aE+A
	amipOzFHYZq/5ttSxrQZubv8+H6jqArRLlQxECildSRCbORrChkxBpyq/Wmcg1gB
	a0CHqhK6PujFAL5Z8lw14GnXqbV65/CMshfXzyjv7/CyRhPiIbByCNH5nwlc+lC1
	bqC0erzIUuirM8G+IQpCaWF+pQ7R3xdBgIJRa8hIxocN+4oBtUScgi0HgTc0sANA
	hbSiXc1CVGgK76AgqUzyTxv4VTn4RSZXyVSUjulruBFdBe89YvAMSg7jNUFM6WOB
	4OoRPUmtMOV7bEQSnRe6Acx5O15JsbXIrojHQ7VKwTQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1vRZtbL3BFJq for <netdev@vger.kernel.org>;
	Mon, 17 Jul 2023 11:43:01 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R47Fw6XhYzBHXhP;
	Mon, 17 Jul 2023 11:43:00 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Jul 2023 11:43:00 +0800
From: hanyu001@208suo.com
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
Subject: sfc: falcon: Prefer unsigned int to bare use of unsigned
In-Reply-To: <tencent_EE1674B8CDD721F12D12287A857E04C5DB0A@qq.com>
References: <tencent_EE1674B8CDD721F12D12287A857E04C5DB0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ab907800461dadf95c332a097f58e6f0@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix checkpatch warnings:

./drivers/net/ethernet/sfc/falcon/net_driver.h:1167: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'
./drivers/net/ethernet/sfc/falcon/net_driver.h:1188: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'
./drivers/net/ethernet/sfc/falcon/net_driver.h:1188: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'
./drivers/net/ethernet/sfc/falcon/net_driver.h:1202: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/sfc/falcon/net_driver.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/net_driver.h 
b/drivers/net/ethernet/sfc/falcon/net_driver.h
index a2c7139..d2d8f9b 100644
--- a/drivers/net/ethernet/sfc/falcon/net_driver.h
+++ b/drivers/net/ethernet/sfc/falcon/net_driver.h
@@ -1164,7 +1164,7 @@ struct ef4_nic_type {
   
*************************************************************************/

  static inline struct ef4_channel *
-ef4_get_channel(struct ef4_nic *efx, unsigned index)
+ef4_get_channel(struct ef4_nic *efx, unsigned int  index)
  {
      EF4_BUG_ON_PARANOID(index >= efx->n_channels);
      return efx->channel[index];
@@ -1185,7 +1185,7 @@ struct ef4_nic_type {
               (_efx)->channel[_channel->channel - 1] : NULL)

  static inline struct ef4_tx_queue *
-ef4_get_tx_queue(struct ef4_nic *efx, unsigned index, unsigned type)
+ef4_get_tx_queue(struct ef4_nic *efx, unsigned int index, unsigned int 
type)
  {
      EF4_BUG_ON_PARANOID(index >= efx->n_tx_channels ||
                  type >= EF4_TXQ_TYPES);
@@ -1199,7 +1199,7 @@ static inline bool 
ef4_channel_has_tx_queues(struct ef4_channel *channel)
  }

  static inline struct ef4_tx_queue *
-ef4_channel_get_tx_queue(struct ef4_channel *channel, unsigned type)
+ef4_channel_get_tx_queue(struct ef4_channel *channel, unsigned int 
type)
  {
      EF4_BUG_ON_PARANOID(!ef4_channel_has_tx_queues(channel) ||
                  type >= EF4_TXQ_TYPES);

