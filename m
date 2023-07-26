Return-Path: <netdev+bounces-21399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74DD76381B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AE21C212F9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1A014ABD;
	Wed, 26 Jul 2023 13:52:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975EBA43
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:52:25 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1EF10F1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:52:21 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63cfd6e3835so20788806d6.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690379540; x=1690984340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FwzqynApyCIwDZrlp7k7WvbzseGEKhg7/eSBgUVM+NY=;
        b=RXUzj2tkfV97nRcRSRh8ICYs00EluUJk4CDuxWj3b3TlaJJR1Y/2rAdELKqHBIF0pS
         Uwfn2wRKMzauwEuCwzh9QusNs7bJSTIrSn8mDDZ+VCd5UyeoKyZU17KD09hxGfmnYBHX
         Pqqmvn5Jbz6KUlMSE5KveMDILYYXqxilYPAWAHdo4V+9MSnkAdVpR5bWw4YuU5tOwUII
         DOsQ8zTS2J0eJKi0N3yyqi0iHfHScRpYcD3w/oz6f179gXM4WGEFAEPE3qKQ6f9JXN2/
         /ZjXpj4Cf1SFOIeaBo6qaF8kg5d5OKnldHfnNKz2FHy9xi2jCjdrtvo1QgF7zpN7iD/u
         2yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379540; x=1690984340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwzqynApyCIwDZrlp7k7WvbzseGEKhg7/eSBgUVM+NY=;
        b=QtUXc62A13SAAIvDIZ4czmTSlbPeWx9LK4ZTnCF1NX1sQCtkQbQ67oMGJI2+C4E7Jr
         1LXm9rPtlju89noa6R9hdgxloyz3MevJ3JFxNWE4VvUeCJ8SUhlc+u0hY5SW4Kng4UZR
         IM4lup/gLNcCxdhlI/slRUobKtft+LvFkU6V5oUA7t91fZy1OGteQADWg2CDnrMtPXqm
         01mjLU2kz7pQMMzjR5xd4Ew2j8l8wK4+wtXInvkakREdbqexhPsRAhRoipetnsKktnQg
         sVCueptc29DABvprya+3QkfUDm38c9lFo0QLGcZ/cDR4mfPJW1Pd0VbJcZ6WkpkMe8Ay
         08Wg==
X-Gm-Message-State: ABy/qLb2tKIaZl4DTFiAGclh63udHVZaKSrqNjPtn2Iu3v7Wiu1OoO7l
	mfNgJNmDyGbjSjlggQWMvWuhlg==
X-Google-Smtp-Source: APBJJlFf/lB9tcZ/oPPZ4pkskHUpocjxSJbKi/36vG9DNQNDDjmi5isoCpo6Eb1EZmpmwxU9qmnopQ==
X-Received: by 2002:a0c:dd0b:0:b0:630:1faa:a404 with SMTP id u11-20020a0cdd0b000000b006301faaa404mr1846267qvk.39.1690379540451;
        Wed, 26 Jul 2023 06:52:20 -0700 (PDT)
Received: from mbili.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id l12-20020a0ce08c000000b00632209f7157sm5049846qvk.143.2023.07.26.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:52:19 -0700 (PDT)
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
	torvalds@linuxfoundation.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 1/1] net: sched: cls_u32: Fix match key mis-addressing
Date: Wed, 26 Jul 2023 09:51:51 -0400
Message-Id: <20230726135151.416917-1-jhs@mojatatu.com>
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

When creating table match entries all of hash table id, bucket id and
node (match entry id) are needed to be either specified by the user or
reasonable in-kernel defaults are used. The in-kernel default for a table id is
0x800(omnipresent root table); for bucketid it is 0x0. Prior to this fix there
was none for a nodeid i.e. the code assumed that the user passed the correct
nodeid and if the user passes a nodeid of 0 (as Mingi Cho did) then that is what
was used. But nodeid of 0 is reserved for identifying the table. This is not
a problem until we dump. The dump code notices that the nodeid is zero and
assumes it is referencing a table and therefore references table struct
tc_u_hnode instead of what was created i.e match entry struct tc_u_knode.

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
 net/sched/cls_u32.c | 56 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 5abf31e432ca..907e58841fe8 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1024,18 +1024,62 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		return -EINVAL;
 	}
 
+	/* At this point, we need to derive the new handle that will be used to
+	 * uniquely map the identity of this table match entry. The
+	 * identity of the entry that we need to construct is 32 bits made of:
+	 *     htid(12b):bucketid(8b):node/entryid(12b)
+	 *
+	 * At this point _we have the table(ht)_ in which we will insert this
+	 * entry. We carry the table's id in variable "htid".
+	 * Note that earlier code picked the ht selection either by a) the user
+	 * providing the htid specified via TCA_U32_HASH attribute or b) when
+	 * no such attribute is passed then the root ht, is default to at ID
+	 * 0x[800][00][000]. Rule: the root table has a single bucket with ID 0.
+	 * If OTOH the user passed us the htid, they may also pass a bucketid of
+	 * choice. 0 is fine. For example a user htid is 0x[600][01][000] it is
+	 * indicating hash bucketid of 1. Rule: the entry/node ID _cannot_ be
+	 * passed via the htid, so even if it was non-zero it will be ignored.
+	 *
+	 * We may also have a handle, if the user passed one. The handle also
+	 * carries the same addressing of htid(12b):bucketid(8b):node/entryid(12b).
+	 * Rule: the bucketid on the handle is ignored even if one was passed;
+	 * rather the value on "htid" is always assumed to be the bucketid.
+	 */
 	if (handle) {
+		/* Rule: The htid from handle and tableid from htid must match */
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
+		 * need to finalize the table entry identification with the last
+		 * part - the node/entryid(12b)). Rule: Nodeid _cannot be 0_ for
+		 * entries. Rule: nodeid of 0 is reserved only for tables(see
+		 * earlier code which processes TC_U32_DIVISOR attribute).
+		 * Rule: The nodeid can only be derived from the handle (and not
+		 * htid).
+		 * Rule: if the handle specified zero for the node id example
+		 * 0x60000000, then pick a new nodeid from the pool of IDs
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
+		/* The user did not give us a handle; lets just generate one
+		 * from the table's pool of nodeids.
+		 */
 		handle = gen_new_kid(ht, htid);
+	}
 
 	if (tb[TCA_U32_SEL] == NULL) {
 		NL_SET_ERR_MSG_MOD(extack, "Selector not specified");
-- 
2.34.1


