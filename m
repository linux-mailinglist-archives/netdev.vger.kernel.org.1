Return-Path: <netdev+bounces-16641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B573474E1C2
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 01:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C62281498
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD3171D7;
	Mon, 10 Jul 2023 23:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E4171D5
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:03:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB20F1B2
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BUKHHIWIV70WqkoBT9nqj4AzEgmD1g5PkeHwMxLn0n8=; b=Xs8d2nPqqA2w1+mawSs2qGx2dc
	WshrxMlC7c4ULkalmNlQ6wquTCNQlnBsC6pFzZui993PrOO4sDZxM0zclzUjuWBzuYoRC/1NRZQoU
	8RE08EQ0b+tLv2fnsYuIuL9Os0b9ehyXqFEIH1tu45oMXKGMIOEXJ4TaECWvkC70Y4cWOkcK8Ea6x
	68FOuR4KKa0CxFfNpkaMNYMDF1rgpZ7529H7DNI+1mIFGNTJ0q2V/ZCmx+Ee5983I98W9dTs26u4U
	1fti52Zz56YTLxAoaPl0UFbedPU1IBirqeHs5DeOKJoY5T4DF+Y/lwnTkqMQHywxE9D08wI1XEiXD
	XOkBA6uQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qIzuW-00CuO1-1w;
	Mon, 10 Jul 2023 23:03:16 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	Moshe Shemesh <moshe@mellanox.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 05/12] devlink: fix kernel-doc notation warnings
Date: Mon, 10 Jul 2023 16:03:05 -0700
Message-ID: <20230710230312.31197-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710230312.31197-1-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Spell function or struct member names correctly.
Use ':' instead of '-' for struct member entries.
Mark one field as private in kernel-doc.
Add a few entries that were missing.
Fix a typo.

These changes prevent kernel-doc warnings:

devlink.h:252: warning: Function parameter or member 'field_id' not described in 'devlink_dpipe_match'
devlink.h:267: warning: Function parameter or member 'field_id' not described in 'devlink_dpipe_action'
devlink.h:310: warning: Function parameter or member 'match_values_count' not described in 'devlink_dpipe_entry'
devlink.h:355: warning: Function parameter or member 'list' not described in 'devlink_dpipe_table'
devlink.h:374: warning: Function parameter or member 'actions_dump' not described in 'devlink_dpipe_table_ops'
devlink.h:374: warning: Function parameter or member 'matches_dump' not described in 'devlink_dpipe_table_ops'
devlink.h:374: warning: Function parameter or member 'entries_dump' not described in 'devlink_dpipe_table_ops'
devlink.h:374: warning: Function parameter or member 'counters_set_update' not described in 'devlink_dpipe_table_ops'
devlink.h:374: warning: Function parameter or member 'size_get' not described in 'devlink_dpipe_table_ops'
devlink.h:384: warning: Function parameter or member 'headers' not described in 'devlink_dpipe_headers'
devlink.h:384: warning: Function parameter or member 'headers_count' not described in 'devlink_dpipe_headers'
devlink.h:398: warning: Function parameter or member 'unit' not described in 'devlink_resource_size_params'
devlink.h:487: warning: Function parameter or member 'id' not described in 'devlink_param'
devlink.h:645: warning: Function parameter or member 'overwrite_mask' not described in 'devlink_flash_update_params'

Fixes: 1555d204e743 ("devlink: Support for pipeline debug (dpipe)")
Fixes: d9f9b9a4d05f ("devlink: Add support for resource abstraction")
Fixes: eabaef1896bc ("devlink: Add devlink_param register and unregister")
Fixes: 5d5b4128c4ca ("devlink: introduce flash update overwrite mask")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Arkadi Sharshevsky <arkadis@mellanox.com>
Cc: Moshe Shemesh <moshe@mellanox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
---
 include/net/devlink.h |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff -- a/include/net/devlink.h b/include/net/devlink.h
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -221,7 +221,7 @@ struct devlink_dpipe_field {
 /**
  * struct devlink_dpipe_header - dpipe header object
  * @name: header name
- * @id: index, global/local detrmined by global bit
+ * @id: index, global/local determined by global bit
  * @fields: fields
  * @fields_count: number of fields
  * @global: indicates if header is shared like most protocol header
@@ -241,7 +241,7 @@ struct devlink_dpipe_header {
  * @header_index: header index (packets can have several headers of same
  *		  type like in case of tunnels)
  * @header: header
- * @fieled_id: field index
+ * @field_id: field index
  */
 struct devlink_dpipe_match {
 	enum devlink_dpipe_match_type type;
@@ -256,7 +256,7 @@ struct devlink_dpipe_match {
  * @header_index: header index (packets can have several headers of same
  *		  type like in case of tunnels)
  * @header: header
- * @fieled_id: field index
+ * @field_id: field index
  */
 struct devlink_dpipe_action {
 	enum devlink_dpipe_action_type type;
@@ -292,7 +292,7 @@ struct devlink_dpipe_value {
  * struct devlink_dpipe_entry - table entry object
  * @index: index of the entry in the table
  * @match_values: match values
- * @matche_values_count: count of matches tuples
+ * @match_values_count: count of matches tuples
  * @action_values: actions values
  * @action_values_count: count of actions values
  * @counter: value of counter
@@ -342,7 +342,9 @@ struct devlink_dpipe_table_ops;
  */
 struct devlink_dpipe_table {
 	void *priv;
+	/* private: */
 	struct list_head list;
+	/* public: */
 	const char *name;
 	bool counters_enabled;
 	bool counter_control_extern;
@@ -355,13 +357,13 @@ struct devlink_dpipe_table {
 
 /**
  * struct devlink_dpipe_table_ops - dpipe_table ops
- * @actions_dump - dumps all tables actions
- * @matches_dump - dumps all tables matches
- * @entries_dump - dumps all active entries in the table
- * @counters_set_update - when changing the counter status hardware sync
+ * @actions_dump: dumps all tables actions
+ * @matches_dump: dumps all tables matches
+ * @entries_dump: dumps all active entries in the table
+ * @counters_set_update:  when changing the counter status hardware sync
  *			  maybe needed to allocate/free counter related
  *			  resources
- * @size_get - get size
+ * @size_get: get size
  */
 struct devlink_dpipe_table_ops {
 	int (*actions_dump)(void *priv, struct sk_buff *skb);
@@ -374,8 +376,8 @@ struct devlink_dpipe_table_ops {
 
 /**
  * struct devlink_dpipe_headers - dpipe headers
- * @headers - header array can be shared (global bit) or driver specific
- * @headers_count - count of headers
+ * @headers: header array can be shared (global bit) or driver specific
+ * @headers_count: count of headers
  */
 struct devlink_dpipe_headers {
 	struct devlink_dpipe_header **headers;
@@ -387,7 +389,7 @@ struct devlink_dpipe_headers {
  * @size_min: minimum size which can be set
  * @size_max: maximum size which can be set
  * @size_granularity: size granularity
- * @size_unit: resource's basic unit
+ * @unit: resource's basic unit
  */
 struct devlink_resource_size_params {
 	u64 size_min;
@@ -457,6 +459,7 @@ struct devlink_flash_notify {
 
 /**
  * struct devlink_param - devlink configuration parameter data
+ * @id: devlink parameter id number
  * @name: name of the parameter
  * @generic: indicates if the parameter is generic or driver specific
  * @type: parameter type
@@ -632,6 +635,7 @@ enum devlink_param_generic_id {
  * struct devlink_flash_update_params - Flash Update parameters
  * @fw: pointer to the firmware data to update from
  * @component: the flash component to update
+ * @overwrite_mask: which types of flash update are supported (may be %0)
  *
  * With the exception of fw, drivers must opt-in to parameters by
  * setting the appropriate bit in the supported_flash_update_params field in

