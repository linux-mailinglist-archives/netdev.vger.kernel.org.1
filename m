Return-Path: <netdev+bounces-20473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891E075FA94
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7228A1C20B36
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C3DDA3;
	Mon, 24 Jul 2023 15:19:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5A8839
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:19:04 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22C3199B
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:19:02 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-403b3273074so20694251cf.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690211941; x=1690816741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JTgcwHv6tNn2n8tPdtjRBBt5SS53NoEtTVDGTyM7kRU=;
        b=wn3IRKQmi/999MP9kMy7ITASrDrcM/3crXdiRJqDimRV6O+GNXf/jAyMI9u4gisV4+
         8Gftns7PCrlsS8enwhe4g2TPziB1YAnZ3bEk8BvN9f20BnM2wY198uwo65KDL1KuJKyR
         +e1fJ4r2tIof5rJTCfcnoTQB4MR7d/E9I9S7lFb5kIDq/fWiqpYu9mRM97myFLHqvqNl
         d0dU4vR2u02lqgAAqPWtCt9qwnE+AxadMD4PZObybVV44Fhjn30xwUE9M36ytvppQY3X
         sbcPmaju5OL7K/sruO+vDRbT4C7ryPapas/XKTLJ1z1jKGK1Y2/b8zh73L1LQVHw+30J
         kgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690211941; x=1690816741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTgcwHv6tNn2n8tPdtjRBBt5SS53NoEtTVDGTyM7kRU=;
        b=N4qxdyDY+RGmopI4wF+rkqjpFaqLGuCE8Z5cZoVOVAJRXlbf9oGBbsrWmL630ImeqT
         a7hFizhkfgukRYnZr5+qNdaXJObxlsEs5edtrph2+1k84wA/1ek5s67J63sarqm3TnYH
         WB9dz92AGNbYlFI+KOnqXU9NVleq2WFd+EDwfeASQmg5zI3Um7b5s7HDlwBeyGtcCFgh
         wKS3sXP0jfZCD/cu/WBAdKVZGfrjBfcLTiFHIgGbHc7OC6jqryULy/13fUxoVqlA5e7d
         J8CjfU2nxNOTou6GFGr7WRJY72R6Sy83pJVXjnuxnY5bTnateOT2FjkGM3a3OMibW0EA
         AJCQ==
X-Gm-Message-State: ABy/qLYHnys0Vj0pTSB67faT/BG/WyrOikLR1vxH0+kvxWPBXXMqFzlj
	3xyq3ilFqdaiQMPOJLOEY1tE1Q==
X-Google-Smtp-Source: APBJJlE4pe1nW5vyKnoJKJ66ljCs4An90weRKv6lGbFEtws4aEG4rD64SBY7lIj5rTqx547DWB31Kw==
X-Received: by 2002:a05:622a:185:b0:3fd:ed14:6eb9 with SMTP id s5-20020a05622a018500b003fded146eb9mr94671qtw.11.1690211941501;
        Mon, 24 Jul 2023 08:19:01 -0700 (PDT)
Received: from mbili.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r26-20020ac8521a000000b00402ed9adfa1sm3381643qtn.87.2023.07.24.08.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 08:19:00 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	mgcho.minic@gmail.com,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] net: sched: cls_u32: Fix match key mis-addressing
Date: Mon, 24 Jul 2023 11:18:49 -0400
Message-Id: <20230724151849.323497-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A match entry is uniquely identified with an "address" or "path" in the
form of: hashtable ID(12b):bucketid(8b):nodeid(12b).
A table on which the entry is inserted assumes the address with nodeid of
zero.

When creating table match entries all of hash table id, bucket id and
node (match entry id) are needed to be either specified by the user or
via reasonable in-kernel defaults. The in-kernel default for a table
id is 0x800(omnipresent root table); for bucketid it is 0x0. Prior to
this fix there was none for a nodeid i.e. the code assumed that the
user passed the correct nodeid and if the user passes a nodeid of 0
(as Mingi Cho did) then that is what was assumed. But nodeid of 0
is reserved for identifying the table. This is not a problem until
we dump. The dump code notices that the nodeid is zero and assumes
it is referencing a table and therefore table struct tc_u_hnode instead
of what was created i.e match entry struct tc_u_knode.

Ming does an equivalent of:
tc filter add dev dummy0 parent 10: prio 1 handle 0x1000 \
protocol ip u32 match ip src 10.0.0.1/32 classid 10:1 action ok

Essentially specifying a table id 0, bucketid 1 and nodeid of zero
Tableid 0 is remapped to the default of 0x800.
Bucketid 1 is ignored and defaults to 0x00.
Nodeid was assumed to be what Ming passed - 0x000

dumping before fix shows:
~$ tc filter ls dev dummy0 parent 10:
filter protocol ip pref 1 u32 chain 0
filter protocol ip pref 1 u32 chain 0 fh 800: ht divisor 1
filter protocol ip pref 1 u32 chain 0 fh 800: ht divisor -30591

Note that the last line reports a table instead of a match entry
(you can tell this because it says "ht divisor...").
As a result of reporting the wrong data type (misinterpretting of struct
tc_u_knode as being struct tc_u_hnode) the divisor is reported with value
of -30591. Ming identified this as part of the heap address
(physmap_base is 0xffff8880 (-30591 - 1)).

The fix is to ensure that when table entry matches are added and no
nodeid is specified (i.e nodeid == 0) then we get the next available
nodeid from the table's pool.

After the fix, this is what the dump shows:
$ tc filter ls dev dummy0 parent 10:
filter protocol ip pref 1 u32 chain 0
filter protocol ip pref 1 u32 chain 0 fh 800: ht divisor 1
filter protocol ip pref 1 u32 chain 0 fh 800::800 order 2048 key ht 800 bkt 0 flowid 10:1 not_in_hw
  match 0a000001/ffffffff at 12
	action order 1: gact action pass
	 random type none pass val 0
	 index 1 ref 1 bind 1

Reported-by: Mingi Cho <mgcho.minic@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_u32.c | 48 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 5abf31e432ca..e0eabbcce9d4 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1024,18 +1024,54 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		return -EINVAL;
 	}
 
+	/* If we got this far _we have the table(ht)_ with its matching htid.
+	 * Note that earlier the ht selection is a result of either a) the user
+	 * providing the htid specified via TCA_U32_HASH attribute or b) when
+	 * no such attribute is passed then a default ht, typically root at
+	 * 0x80000000, is chosen.
+	 * The passed htid will also hold the bucketid. 0 is fine. For example
+	 * of the root ht, 0x80000000 is indicating bucketid 0, whereas a user
+	 * passed htid may have 0x60001000 indicating hash bucketid 1.
+	 *
+	 * We may also have a handle, if the user passed one. The handle carries
+	 * annotation of htid(12b):bucketid(8b):node/entryid(12b).
+	 * The value of bucketid on the handle is ignored even if one was passed;
+	 * rather the value on the htid is always assumed to be the bucketid.
+	 */
 	if (handle) {
+		/* The tableid from handle and tableid from htid must match */
 		if (TC_U32_HTID(handle) && TC_U32_HTID(handle ^ htid)) {
 			NL_SET_ERR_MSG_MOD(extack, "Handle specified hash table address mismatch");
 			return -EINVAL;
 		}
-		handle = htid | TC_U32_NODE(handle);
-		err = idr_alloc_u32(&ht->handle_idr, NULL, &handle, handle,
-				    GFP_KERNEL);
-		if (err)
-			return err;
-	} else
+		/* Ok, so far we have a valid htid(12b):bucketid(8b) but we
+		 * need to finalize our handle to point to the entry as well
+		 * (with a proper node/entryid(12b)). Nodeid _cannot be 0_ for
+		 * entries since it is reserved only for tables(see earlier
+		 * code which processes TC_U32_DIVISOR attribute).
+		 * if the handle did not specify a non-zero nodeid (example
+		 * passed 0x60000000) then pick a new one from the pool of IDs
+		 * this hash table has been allocating from.
+		 * If OTOH it is specified (i.e for example the user passed a
+		 * handle such as 0x60000123), then we use it generate our final
+		 * handle which is used to uniquely identify the match entry.
+		 */
+		if (!TC_U32_NODE(handle)) {
+			handle = gen_new_kid(ht, htid);
+		} else {
+			handle = htid | TC_U32_NODE(handle);
+			err = idr_alloc_u32(&ht->handle_idr, NULL, &handle,
+					    handle, GFP_KERNEL);
+			if (err)
+				return err;
+		}
+	} else {
+		/* we dont have a handle lets just generate one based on htid
+		 * recall that htid has both the table and bucket ids already
+		 * encoded, only missing piece is the nodeid.
+		 */
 		handle = gen_new_kid(ht, htid);
+	}
 
 	if (tb[TCA_U32_SEL] == NULL) {
 		NL_SET_ERR_MSG_MOD(extack, "Selector not specified");
-- 
2.34.1


