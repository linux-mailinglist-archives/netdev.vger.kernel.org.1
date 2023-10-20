Return-Path: <netdev+bounces-43093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A110C7D1654
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED522B2145B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3E22323;
	Fri, 20 Oct 2023 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/m5sh4w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7F22318
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 19:37:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303DED5D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697830677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NtRMAxR+Ue4rX4KZZUpffz2stN0dFpO9Ia6gRLh85E=;
	b=c/m5sh4w2emn+2+NfK6W0O3G5eXV2JMyYYroa7fnL3lk8UasXyw8eploOyN/1nVPRZl580
	JbqVgwk1z0uwNvYiXOzGQnQB4jnkFhzG9gQT3v+jZb/WqPs3UDLFC367XUddPg1tF2RapS
	4UBNzjkXWNK/l3XWbky5ucc296BcxPI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-MpDWGtoANyumZVIETc3cJA-1; Fri, 20 Oct 2023 15:37:52 -0400
X-MC-Unique: MpDWGtoANyumZVIETc3cJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87859185A7A7;
	Fri, 20 Oct 2023 19:37:51 +0000 (UTC)
Received: from p1.luc.com (unknown [10.45.226.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9491DC15BB8;
	Fri, 20 Oct 2023 19:37:49 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	mschmidt@redhat.com,
	dacampbe@redhat.com,
	poros@redhat.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-next 2/6] i40e: Remove _t suffix from enum type names
Date: Fri, 20 Oct 2023 21:37:38 +0200
Message-ID: <20231020193746.2274379-2-ivecera@redhat.com>
In-Reply-To: <20231020193746.2274379-1-ivecera@redhat.com>
References: <20231020193746.2274379-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Enum type names should not be suffixed by '_t'. Either to use
'typedef enum name name_t' to so plain 'name_t var' instead of
'enum name_t var'.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 6 +++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 6e3e2a6d18c4..b3cb79fb8791 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -78,7 +78,7 @@
 #define I40E_MAX_BW_INACTIVE_ACCUM	4 /* accumulate 4 credits max */
 
 /* driver state flags */
-enum i40e_state_t {
+enum i40e_state {
 	__I40E_TESTING,
 	__I40E_CONFIG_BUSY,
 	__I40E_CONFIG_DONE,
@@ -126,7 +126,7 @@ enum i40e_state_t {
 	BIT_ULL(__I40E_PF_RESET_AND_REBUILD_REQUESTED)
 
 /* VSI state flags */
-enum i40e_vsi_state_t {
+enum i40e_vsi_state {
 	__I40E_VSI_DOWN,
 	__I40E_VSI_NEEDS_RESTART,
 	__I40E_VSI_SYNCING_FILTERS,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 20b77398f060..65c714d0bfff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -35,7 +35,7 @@ enum i40e_ptp_pin {
 	GPIO_4
 };
 
-enum i40e_can_set_pins_t {
+enum i40e_can_set_pins {
 	CANT_DO_PINS = -1,
 	CAN_SET_PINS,
 	CAN_DO_PINS
@@ -193,7 +193,7 @@ static bool i40e_is_ptp_pin_dev(struct i40e_hw *hw)
  * return CAN_DO_PINS if pins can be manipulated within a NIC or
  * return CANT_DO_PINS otherwise.
  **/
-static enum i40e_can_set_pins_t i40e_can_set_pins(struct i40e_pf *pf)
+static enum i40e_can_set_pins i40e_can_set_pins(struct i40e_pf *pf)
 {
 	if (!i40e_is_ptp_pin_dev(&pf->hw)) {
 		dev_warn(&pf->pdev->dev,
@@ -1071,7 +1071,7 @@ static void i40e_ptp_set_pins_hw(struct i40e_pf *pf)
 static int i40e_ptp_set_pins(struct i40e_pf *pf,
 			     struct i40e_ptp_pins_settings *pins)
 {
-	enum i40e_can_set_pins_t pin_caps = i40e_can_set_pins(pf);
+	enum i40e_can_set_pins pin_caps = i40e_can_set_pins(pf);
 	int i = 0;
 
 	if (pin_caps == CANT_DO_PINS)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 421fe5675584..1c667408f687 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -58,7 +58,7 @@ static inline u16 i40e_intrl_usec_to_reg(int intrl)
  * mentioning ITR_INDX, ITR_NONE cannot be used as an index 'n' into any
  * register but instead is a special value meaning "don't update" ITR0/1/2.
  */
-enum i40e_dyn_idx_t {
+enum i40e_dyn_idx {
 	I40E_IDX_ITR0 = 0,
 	I40E_IDX_ITR1 = 1,
 	I40E_IDX_ITR2 = 2,
@@ -306,7 +306,7 @@ struct i40e_rx_queue_stats {
 	u64 page_busy_count;
 };
 
-enum i40e_ring_state_t {
+enum i40e_ring_state {
 	__I40E_TX_FDIR_INIT_DONE,
 	__I40E_TX_XPS_INIT_DONE,
 	__I40E_RING_STATE_NBITS /* must be last */
-- 
2.41.0


