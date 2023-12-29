Return-Path: <netdev+bounces-60580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578381FFAA
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 14:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3071C1C2169F
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E7A111BF;
	Fri, 29 Dec 2023 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eJJYoPz7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5211703
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdfbd4e8caso3857851a12.0
        for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 05:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703856467; x=1704461267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDOUkvqRc89svjTphHPNt5NLbzTjP1n02P4Tkn2TiME=;
        b=eJJYoPz7vAEMHlkb5YNFHYYj89cP5xofeGWOMd/PmlmqhuWS/kqPn24Lki84b2OP/l
         NvtUDY/1slBjAXKZ5DAHvVF97eAtoMRdf94zIQH43PXyDzzOYoNOMEUDh6F1PI8Yw7zW
         /8MulTDimRSVbNeSu8DxuC5yEEKMlx1fIX7sZpvrhukEmi+UFnDrytkrj9YQHVteoqWF
         CGBeayWpWqyRciIUp/23InOhttPuLCspyHOQVfdD5siJTPuiGlvESynMewm5Oi1X6GA7
         bCmL6Xr+7BYxZaLl9ptq0mx6o+pGO14YuFZGylQBwsw+Yy9daGb6pb9UNeW9jYfxayRR
         UT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703856467; x=1704461267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDOUkvqRc89svjTphHPNt5NLbzTjP1n02P4Tkn2TiME=;
        b=Zp3iVSLW9l1hlDyr1O1GRBYTT6xWjJ4OCqPXEX+rL1Zri9fbxDqbPLx7JjCNLUEU2V
         O6FJl7JhqmNlfK3gPi+2YpqcW2DJw3Ij52OB97MGv0bEVyWx8eKjtqQoXY/HKBKa0L7F
         Un2szDQdjmU7e6npPQTQnhSep832irppcw/a/nN88WrlfraG6CPrRI0fystnBz2gQV1H
         wXeeGqxT0WOHCLbDIbm4cvt/bFFIxAg7kIJaiUyIPoK/q+Sv4zw8G9GCvH+d26gPyHO6
         dYrJ8dXaGPVgVCVD+Y/Q8J/rMk/n9Jk4oGIJNuoH98jp+cjtKIoDz43UtFUO/BVbMOU/
         70Og==
X-Gm-Message-State: AOJu0YzNVrj7OYVAD5P8LouGSgxZVjUeuJTFNrZDLr9Aw0qHVeFv9GgT
	XJ7mP72RDdRym45CtM126Nl35VpS2qmGa0YNPsLmmymxag==
X-Google-Smtp-Source: AGHT+IFDrAN1DkzwQ+FdMufC4NdtlV7VLh6eR27mpNQdGUVHjF5J3EQkFrqBAo1s6LVvF5uF9L0mbQ==
X-Received: by 2002:a05:6a20:cf14:b0:195:1bcf:3aea with SMTP id hy20-20020a056a20cf1400b001951bcf3aeamr9381227pzb.28.1703856466783;
        Fri, 29 Dec 2023 05:27:46 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id dj15-20020a17090ad2cf00b0028bbf4c0264sm19863002pjb.10.2023.12.29.05.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 05:27:46 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next] net/sched: introduce ACT_P_BOUND return code
Date: Fri, 29 Dec 2023 10:26:41 -0300
Message-Id: <20231229132642.1489088-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bound actions always return '0' and as of today we rely on '0'
being returned in order to properly skip bound actions in
tcf_idr_insert_many. In order to further improve maintainability,
introduce the ACT_P_BOUND return code.

Actions are updated to return 'ACT_P_BOUND' instead of plain '0'.
tcf_idr_insert_many is then updated to check for 'ACT_P_BOUND'.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/net/act_api.h      | 1 +
 net/sched/act_api.c        | 2 +-
 net/sched/act_bpf.c        | 2 +-
 net/sched/act_connmark.c   | 2 +-
 net/sched/act_csum.c       | 4 ++--
 net/sched/act_ct.c         | 2 +-
 net/sched/act_ctinfo.c     | 2 +-
 net/sched/act_gact.c       | 2 +-
 net/sched/act_gate.c       | 2 +-
 net/sched/act_ife.c        | 2 +-
 net/sched/act_mirred.c     | 2 +-
 net/sched/act_mpls.c       | 2 +-
 net/sched/act_nat.c        | 2 +-
 net/sched/act_pedit.c      | 2 +-
 net/sched/act_police.c     | 2 +-
 net/sched/act_sample.c     | 2 +-
 net/sched/act_simple.c     | 2 +-
 net/sched/act_skbedit.c    | 2 +-
 net/sched/act_skbmod.c     | 2 +-
 net/sched/act_tunnel_key.c | 2 +-
 net/sched/act_vlan.c       | 2 +-
 21 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index ea13e1e4a7c2..447985a45ef6 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -137,6 +137,7 @@ struct tc_action_ops {
 
 #ifdef CONFIG_NET_CLS_ACT
 
+#define ACT_P_BOUND 0
 #define ACT_P_CREATED 1
 #define ACT_P_DELETED 1
 
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index a44c097a880d..ef70d4771811 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1313,7 +1313,7 @@ void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
 	tcf_act_for_each_action(i, a, actions) {
 		struct tcf_idrinfo *idrinfo;
 
-		if (init_res[i] == 0) /* Bound */
+		if (init_res[i] == ACT_P_BOUND)
 			continue;
 
 		idrinfo = a->idrinfo;
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index b0455fda7d0b..6cfee6658103 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -318,7 +318,7 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
 	} else if (ret > 0) {
 		/* Don't override defaults. */
 		if (bind)
-			return 0;
+			return ACT_P_BOUND;
 
 		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
 			tcf_idr_release(*act, bind);
diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 0d7aee8933c5..f8762756657d 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -146,7 +146,7 @@ static int tcf_connmark_init(struct net *net, struct nlattr *nla,
 	} else if (ret > 0) {
 		ci = to_connmark(*a);
 		if (bind) {
-			err = 0;
+			err = ACT_P_BOUND;
 			goto out_free;
 		}
 		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 8ed285023a40..7f8b1f2f2ed9 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -77,8 +77,8 @@ static int tcf_csum_init(struct net *net, struct nlattr *nla,
 		}
 		ret = ACT_P_CREATED;
 	} else if (err > 0) {
-		if (bind)/* dont override defaults */
-			return 0;
+		if (bind) /* dont override defaults */
+			return ACT_P_BOUND;
 		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
 			tcf_idr_release(*a, bind);
 			return -EEXIST;
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index f69c47945175..c3e004b5b820 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1349,7 +1349,7 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 		res = ACT_P_CREATED;
 	} else {
 		if (bind)
-			return 0;
+			return ACT_P_BOUND;
 
 		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
 			tcf_idr_release(*a, bind);
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 4d15b6a6169c..e620f9a84afe 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -221,7 +221,7 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 		ret = ACT_P_CREATED;
 	} else if (err > 0) {
 		if (bind) /* don't override defaults */
-			return 0;
+			return ACT_P_BOUND;
 		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
 			tcf_idr_release(*a, bind);
 			return -EEXIST;
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index 904ab3d457ef..4af3b7ec249f 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -108,7 +108,7 @@ static int tcf_gact_init(struct net *net, struct nlattr *nla,
 		ret = ACT_P_CREATED;
 	} else if (err > 0) {
 		if (bind)/* dont override defaults */
-			return 0;
+			return ACT_P_BOUND;
 		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
 			tcf_idr_release(*a, bind);
 			return -EEXIST;
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 393b78729216..c681cd011afd 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -356,7 +356,7 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 		return err;
 
 	if (err && bind)
-		return 0;
+		return ACT_P_BOUND;
 
 	if (!err) {
 		ret = tcf_idr_create_from_flags(tn, index, est, a,
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index bc7611b0744c..0e867d13beb5 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -548,7 +548,7 @@ static int tcf_ife_init(struct net *net, struct nlattr *nla,
 	exists = err;
 	if (exists && bind) {
 		kfree(p);
-		return 0;
+		return ACT_P_BOUND;
 	}
 
 	if (!exists) {
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index d1f9794ca9b7..12386f590b0f 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -135,7 +135,7 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 		return err;
 	exists = err;
 	if (exists && bind)
-		return 0;
+		return ACT_P_BOUND;
 
 	if (tb[TCA_MIRRED_BLOCKID] && parm->ifindex) {
 		NL_SET_ERR_MSG_MOD(extack,
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 1010dc632874..34b8edb6cc77 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -195,7 +195,7 @@ static int tcf_mpls_init(struct net *net, struct nlattr *nla,
 		return err;
 	exists = err;
 	if (exists && bind)
-		return 0;
+		return ACT_P_BOUND;
 
 	if (!exists) {
 		ret = tcf_idr_create(tn, index, est, a, &act_mpls_ops, bind,
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index 4184af5abbf3..a180e724634e 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -69,7 +69,7 @@ static int tcf_nat_init(struct net *net, struct nlattr *nla, struct nlattr *est,
 		ret = ACT_P_CREATED;
 	} else if (err > 0) {
 		if (bind)
-			return 0;
+			return ACT_P_BOUND;
 		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
 			tcf_idr_release(*a, bind);
 			return -EEXIST;
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 1ef8fcfa9997..2ef22969f274 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -202,7 +202,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		ret = ACT_P_CREATED;
 	} else if (err > 0) {
 		if (bind)
-			return 0;
+			return ACT_P_BOUND;
 		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
 			ret = -EEXIST;
 			goto out_release;
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index f3121c5a85e9..e119b4a3db9f 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -77,7 +77,7 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 		return err;
 	exists = err;
 	if (exists && bind)
-		return 0;
+		return ACT_P_BOUND;
 
 	if (!exists) {
 		ret = tcf_idr_create(tn, index, NULL, a,
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 4c670e7568dc..c5c61efe6db4 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -66,7 +66,7 @@ static int tcf_sample_init(struct net *net, struct nlattr *nla,
 		return err;
 	exists = err;
 	if (exists && bind)
-		return 0;
+		return ACT_P_BOUND;
 
 	if (!exists) {
 		ret = tcf_idr_create(tn, index, est, a,
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index 4b84514534f3..0a3e92888295 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -118,7 +118,7 @@ static int tcf_simp_init(struct net *net, struct nlattr *nla,
 		return err;
 	exists = err;
 	if (exists && bind)
-		return 0;
+		return ACT_P_BOUND;
 
 	if (tb[TCA_DEF_DATA] == NULL) {
 		if (exists)
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index ce7008cf291c..754f78b35bb8 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -209,7 +209,7 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 		return err;
 	exists = err;
 	if (exists && bind)
-		return 0;
+		return ACT_P_BOUND;
 
 	if (!flags) {
 		if (exists)
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index dffa990a9629..bcb673ab0008 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -157,7 +157,7 @@ static int tcf_skbmod_init(struct net *net, struct nlattr *nla,
 		return err;
 	exists = err;
 	if (exists && bind)
-		return 0;
+		return ACT_P_BOUND;
 
 	if (!lflags) {
 		if (exists)
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 0c8aa7e686ea..300b08aa8283 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -401,7 +401,7 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
 		return err;
 	exists = err;
 	if (exists && bind)
-		return 0;
+		return ACT_P_BOUND;
 
 	switch (parm->t_action) {
 	case TCA_TUNNEL_KEY_ACT_RELEASE:
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 0251442f5f29..836183011a7c 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -151,7 +151,7 @@ static int tcf_vlan_init(struct net *net, struct nlattr *nla,
 		return err;
 	exists = err;
 	if (exists && bind)
-		return 0;
+		return ACT_P_BOUND;
 
 	switch (parm->v_action) {
 	case TCA_VLAN_ACT_POP:
-- 
2.40.1


