Return-Path: <netdev+bounces-41231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD2F7CA450
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C282816C9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B5A1D696;
	Mon, 16 Oct 2023 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="kRoof9V5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7931D52F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:36:26 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F0CB4
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:24 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d093265dfso28552126d6.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697448983; x=1698053783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StO7N7qObpLKeMS2UUJGDzgvWQlAdblUO8FEIzX+gSQ=;
        b=kRoof9V59oHKWCpNVuJho0poCdjhYUlgJrKDRDn7SSZ/v3b8l6bNc2V+xxDlZ+L74L
         bjoUjgd7bxipCC+ZR3bjkuKlR9OaSR2eVWSrADrdeP148FCYa7eJJlkWOFU1gdMHYRLo
         AHvIdJldtMlCWiUYM0bUqJVk5uRhecI4huUgbwUsB7lubFnj/nBJEATga4GJp/b2a9Fe
         KL+M8ohAwvPUlROj3sYUxjmM0iqCQyRXPA4NUwDwcp5OtxXQlBHWpOX57zjKNWZT09s8
         Hm4rr+wT1TQmo7yhyZ6K+6Y8ffrNgeggHoZ1jHTG2mXFpRDmvfRy9PGEL0wxvcWi23WF
         0k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448983; x=1698053783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StO7N7qObpLKeMS2UUJGDzgvWQlAdblUO8FEIzX+gSQ=;
        b=NtuF+Pa9SuDKNJbDUZCh/VEyIy/X4BTmc2ZIaA55+oXDkGt9fcBs8KC4CKvbDzH5PS
         gUu4jk9h7TVBCD/tZllUu+QWLXwUcXw2aes6ydXq2GCL1YxOy/SoUy96zCOd6LPwZzaX
         7TFA5ieoKVrSpChsdJhiFz7egj13pEbl4pzUfEaRmm7fSMaWihvWfxzMvIPMmw7tqFR4
         CAw4CaclOete4ewglCIyRb3zA/+MLpCNIWNZWklpjcg1j6795/JBQeMh+AHBOr0fNCn0
         1cG9K9RGhRgh8eU6AAWBAzCDvgYsV7pcjn+5eqRYDrEa1ajJwKnFcJ2qsKJT4pAimXLv
         bjfw==
X-Gm-Message-State: AOJu0YzPgXCrMWKiy/ND3ToATPddmtb81eJBq/IFDwFNtxI5srIEJQPs
	M7VCnOJVDHsu6fKxIm/sJC/giBVQ3Yb+jjjZYOs=
X-Google-Smtp-Source: AGHT+IFyWUZnQ/XdkbjZTGfKg1OvpPnLl5EDNLNSN8bzIjE93dzEB/Ldu+OYITVuEFqo44rmWv9nBg==
X-Received: by 2002:a05:6214:400a:b0:66d:1572:4ffb with SMTP id kd10-20020a056214400a00b0066d15724ffbmr13667463qvb.3.1697448982681;
        Mon, 16 Oct 2023 02:36:22 -0700 (PDT)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf844000000b0065b1bcd0d33sm3292551qvo.93.2023.10.16.02.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:36:22 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH v7 net-next 17/18] p4tc: Add global counter extern
Date: Mon, 16 Oct 2023 05:35:48 -0400
Message-Id: <20231016093549.181952-18-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016093549.181952-1-jhs@mojatatu.com>
References: <20231016093549.181952-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch implements the P4 counter extern described in
https://staging.p4.org/p4-spec/docs/PSA-v1.2.html section 7.7

We implement both direct and indirect counters.

This is a sample implementation of a Counter.
It's not efficient but it serves the purpose of demonstrating a
slightly complex extern that can be invoked from both the eBPF data path
as well as directly from the P4TC core domain.

Our annotated definition of this P4 extern is as follows:

enum PNA_CounterType_t {
    PACKETS,
    BYTES,
    PACKETS_AND_BYTES
}

@noWarn("unused")
extern Counter<W, S> {
  Counter(bit<32> n_counters, PNA_CounterType_t type);
  void count(in S index);
}

struct tc_ControlPath_Counter<W, S>
{
  @tc_key S index;
  @tc_data W pkts;
  @tc_data W bytes;
}

For a counter declared as follows in a P4 program:

typedef bit<96> PktBytesCounter_t;
const bit<32> NUM_PORTS = 512;

Counter<PktBytesCounter_t, bit<32>>(NUM_PORTS, PNA_CounterType_t.PACKETS_AND_BYTES) counter1;
...
counter1.count(1);
...

The compiler generates a template constructor for the P4
program/pipeline
aP4Proggie as follows:

tc p4template create extern/Counter extid 101 numinstances 1
tc p4template create extern_inst/aP4Proggie/Counter/counter1 \
   instid 1 constructor param PNA_CounterType type bit8 3 \
   control_path tc_key index type bit32 tc_data pkts type bit32 \
   tc_data byte type bit64 tc_numel 512

Runtime for updating(resetting) counter counter1 index 5
looks as follows:

tc p4ctrl update aP4Proggie/extern/Counter/counter1 \
   tc_key index 5 param bytes 0 param pkts 0

Runtime for retrieving counter counter1 index 5 looks as follows:

tc -j p4ctrl get aP4Proggie/extern/Counter/counter1 tc_key \
   index 5 | jq .

[
  {
    "total exts": 0
  },
  {
    "externs": [
      {
        "order": 1,
        "kind": "Counter",
        "instance": "counter1",
        "key": 5,
        "params": [
          {
            "name": "pkts",
            "id": 2,
            "type": "bit32",
            "value": 0
          },
          {
            "name": "bytes",
            "id": 3,
            "type": "bit64",
            "value": 0
          }
        ]
      }
    ]
  }
]

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/p4tc.h                   |   5 +
 net/sched/p4tc/Makefile              |   1 +
 net/sched/p4tc/externs/ext_Counter.c | 541 +++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_bpf.c            |  16 +-
 4 files changed, 560 insertions(+), 3 deletions(-)
 create mode 100644 net/sched/p4tc/externs/ext_Counter.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 080eadf2b..2336adac2 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -734,6 +734,11 @@ struct p4tc_extern_inst {
 	bool				 is_scalar;
 };
 
+struct p4tc_table_counters {
+	u64 bytes;
+	u32 pkts;
+};
+
 int p4tc_pipeline_create_extern_net(struct p4tc_tmpl_extern *tmpl_ext);
 int p4tc_pipeline_del_extern_net(struct p4tc_tmpl_extern *tmpl_ext);
 struct p4tc_extern_inst *
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 57f20b3f3..2af6f77f3 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -6,3 +6,4 @@ obj-y := p4tc_types.o p4tc_pipeline.o p4tc_tmpl_api.o \
 	p4tc_parser_api.o p4tc_hdrfield.o p4tc_action.o p4tc_table.o \
 	p4tc_tbl_entry.o p4tc_runtime_api.o p4tc_bpf.o trace.o p4tc_ext.o \
 	p4tc_tmpl_ext.o
+obj-m += externs/ext_Counter.o
diff --git a/net/sched/p4tc/externs/ext_Counter.c b/net/sched/p4tc/externs/ext_Counter.c
new file mode 100644
index 000000000..4e88e455e
--- /dev/null
+++ b/net/sched/p4tc/externs/ext_Counter.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/externs/ext_Counter.c Example counter extern implementation
+ *
+ * Copyright (c) 2023, Mojatatu Networks
+ * Copyright (c) 2023, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/skbuff.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_arp.h>
+#include <net/netlink.h>
+#include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
+#include <net/tc_wrapper.h>
+#include <net/p4tc.h>
+#include <net/p4tc_ext_api.h>
+#include <net/sock.h>
+#include <net/sch_generic.h>
+#include <linux/filter.h>
+#include <linux/list.h>
+#include <linux/idr.h>
+
+#define EXTERN_COUNTER_ID 101
+#define EXTERN_COUNTER_TYPE_PKTS 1
+#define EXTERN_COUNTER_TYPE_BYTES 2
+#define EXTERN_COUNTER_TYPE_PKTSNBYTES 3
+
+#define PKTNBYTES_KEY_PARAM_ID 1
+#define PKTNBYTES_PKTS_PARAM_ID 2
+#define PKTNBYTES_BYTES_PARAM_ID 3
+#define PKTONLY_KEY_PARAM_ID 1
+#define PKTONLY_PKTS_PARAM_ID 2
+#define BYTEONLY_KEY_PARAM_ID 1
+#define BYTEONLY_BYTES_PARAM_ID 2
+
+struct p4tc_extern_count_inst {
+	struct p4tc_extern_inst common;
+	u8 constr_type;
+};
+
+#define to_count_inst(inst) ((struct p4tc_extern_count_inst *)inst)
+
+static int check_byte_param(struct p4tc_extern_param *byte_param,
+			    struct netlink_ext_ack *extack)
+{
+	struct p4tc_type *type;
+
+	if (!byte_param) {
+		NL_SET_ERR_MSG(extack, "Packet param must be a specified");
+		return -EINVAL;
+	}
+
+	type = byte_param->type;
+	if (!(type->typeid == P4T_U32 && byte_param->bitsz == 32) &&
+	    !(type->typeid == P4T_U64 && byte_param->bitsz == 64)) {
+		NL_SET_ERR_MSG(extack, "Byte param must be a bit32 or a bit64");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int check_pkt_param(struct p4tc_extern_param *pkt_param,
+			   struct netlink_ext_ack *extack)
+{
+	struct p4tc_type *type;
+
+	if (!pkt_param) {
+		NL_SET_ERR_MSG(extack, "Packet param must be a specified");
+		return -EINVAL;
+	}
+
+	type = pkt_param->type;
+	if (!(type->typeid == P4T_U32 && pkt_param->bitsz == 32) &&
+	    !(type->typeid == P4T_U64 && pkt_param->bitsz == 64)) {
+		NL_SET_ERR_MSG(extack,
+			       "Packet param must be a bit32 or a bit64");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int check_params_cnt(struct idr *params_idr,
+			    const u32 params_cnt, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param;
+	unsigned long tmp, id;
+	int i = 0;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id) {
+		i++;
+	}
+
+	if (params_cnt != i) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Expected %u params received %u params",
+				   params_cnt, i);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int check_key_param(struct p4tc_extern_param *key_param,
+			   struct netlink_ext_ack *extack)
+{
+	if (!key_param || !(key_param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY)) {
+		NL_SET_ERR_MSG(extack, "First parameter must be key");
+		return -EINVAL;
+	}
+
+	if (key_param->type->typeid != P4T_U32) {
+		NL_SET_ERR_MSG(extack, "First parameter must be of type bit32");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int check_ext_type_param(struct p4tc_extern_param *ext_type_param,
+				struct netlink_ext_ack *extack)
+{
+	if (!ext_type_param) {
+		NL_SET_ERR_MSG(extack,
+			       "First constructor parameter must be counter type");
+		return -EINVAL;
+	}
+
+	if (ext_type_param->type->typeid != P4T_U8 ||
+	    ext_type_param->bitsz != 8) {
+		NL_SET_ERR_MSG(extack,
+			       "Counter type parameter must be of type bit32");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+p4tc_extern_counter_validate_pktnbytes(struct p4tc_extern_params *control_params,
+				       struct netlink_ext_ack *extack)
+{
+	struct idr *params_idr = &control_params->params_idr;
+	struct p4tc_extern_param *param;
+	int err;
+
+	err = check_params_cnt(params_idr, 3, extack);
+	if (err < 0)
+		return err;
+
+	param = p4tc_ext_param_find_byid(params_idr, PKTNBYTES_KEY_PARAM_ID);
+	err = check_key_param(param, extack);
+	if (err < 0)
+		return err;
+
+	param = p4tc_ext_param_find_byid(params_idr, PKTNBYTES_PKTS_PARAM_ID);
+	err = check_pkt_param(param, extack);
+	if (err < 0)
+		return err;
+
+	param = p4tc_ext_param_find_byid(params_idr, PKTNBYTES_BYTES_PARAM_ID);
+	err = check_byte_param(param, extack);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int
+p4tc_extern_counter_validate_pktonly(struct p4tc_extern_params *control_params,
+				     struct netlink_ext_ack *extack)
+{
+	struct idr *params_idr = &control_params->params_idr;
+	struct p4tc_extern_param *param;
+	int err;
+
+	err = check_params_cnt(params_idr, 2, extack);
+	if (err < 0)
+		return err;
+
+	param = p4tc_ext_param_find_byid(params_idr, PKTONLY_KEY_PARAM_ID);
+	err = check_key_param(param, extack);
+	if (err < 0)
+		return err;
+
+	param = p4tc_ext_param_find_byid(params_idr, PKTONLY_PKTS_PARAM_ID);
+	err = check_pkt_param(param, extack);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int
+p4tc_extern_counter_validate_byteonly(struct p4tc_extern_params *control_params,
+				      struct netlink_ext_ack *extack)
+{
+	struct idr *params_idr = &control_params->params_idr;
+	struct p4tc_extern_param *param;
+	int err;
+
+	err = check_params_cnt(params_idr, 2, extack);
+	if (err < 0)
+		return err;
+
+	param = p4tc_ext_param_find_byid(params_idr, BYTEONLY_KEY_PARAM_ID);
+	err = check_key_param(param, extack);
+	if (err < 0)
+		return err;
+
+	param = p4tc_ext_param_find_byid(params_idr, BYTEONLY_BYTES_PARAM_ID);
+	err = check_byte_param(param, extack);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+/* Skip prepended ext_ from counter kind name */
+#define skip_prepended_ext(ext_kind) (&((ext_kind)[4]))
+
+static struct p4tc_extern_ops ext_Counter_ops;
+
+static int
+p4tc_extern_count_constr(struct p4tc_extern_inst **common,
+			 struct p4tc_extern_params *control_params,
+			 struct p4tc_extern_params *constr_params,
+			 u32 max_num_elems, bool tbl_bindable,
+			 struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *constr_type_param;
+	struct idr *constr_params_idr = &constr_params->params_idr;
+	struct p4tc_extern_params *new_params, *new_constr_params;
+	struct p4tc_extern_count_inst *count_inst;
+	u8 *constr_type;
+	int err = 0;
+
+	constr_type_param = p4tc_ext_param_find_byid(constr_params_idr, 1);
+	if (check_ext_type_param(constr_type_param, extack) < 0)
+		return -EINVAL;
+
+	constr_type = constr_type_param->value;
+	switch (*constr_type) {
+	case EXTERN_COUNTER_TYPE_PKTSNBYTES:
+		err = p4tc_extern_counter_validate_pktnbytes(control_params,
+							     extack);
+		break;
+	case EXTERN_COUNTER_TYPE_BYTES:
+		err = p4tc_extern_counter_validate_byteonly(control_params,
+							    extack);
+		break;
+	case EXTERN_COUNTER_TYPE_PKTS:
+		err = p4tc_extern_counter_validate_pktonly(control_params,
+							   extack);
+		break;
+	default:
+		NL_SET_ERR_MSG(extack,
+			       "Only allowed types are pktsnbytes(1), bytes(2), pkts(3)");
+		return -EINVAL;
+	}
+
+	if (err < 0)
+		return err;
+
+	*common = p4tc_ext_inst_alloc(&ext_Counter_ops,
+				      max_num_elems, tbl_bindable,
+				      skip_prepended_ext(ext_Counter_ops.kind));
+	if (IS_ERR(*common))
+		return PTR_ERR(*common);
+	count_inst = to_count_inst(*common);
+
+	new_params = p4tc_ext_params_copy(control_params);
+	if (IS_ERR(new_params)) {
+		err = PTR_ERR(new_params);
+		goto free_common;
+	}
+	count_inst->common.params = new_params;
+	count_inst->constr_type = *constr_type;
+
+	new_constr_params = p4tc_ext_params_copy(constr_params);
+	if (IS_ERR(new_constr_params)) {
+		err = PTR_ERR(new_constr_params);
+		goto free_params;
+	}
+	count_inst->common.constr_params = new_constr_params;
+
+	err = p4tc_extern_inst_init_elems(&count_inst->common, max_num_elems);
+	if (err < 0)
+		goto free_constr_params;
+
+	return 0;
+
+free_constr_params:
+	p4tc_ext_params_free(new_constr_params, true);
+free_params:
+	p4tc_ext_params_free(new_params, true);
+free_common:
+	kfree(*common);
+	return err;
+}
+
+static void
+p4tc_extern_count_deconstr(struct p4tc_extern_inst *common)
+{
+	p4tc_ext_inst_purge(common);
+	if (common->params)
+		p4tc_ext_params_free(common->params, true);
+	if (common->constr_params)
+		p4tc_ext_params_free(common->constr_params, true);
+	kfree(common);
+}
+
+static void p4tc_skb_extern_count_inc(struct p4tc_extern_params *params,
+				      const u32 param_id, const u64 cnts_inc)
+{
+	struct p4tc_extern_param *param = NULL;
+
+	param = idr_find(&params->params_idr, param_id);
+	if (param) {
+		write_lock_bh(&params->params_lock);
+		if (param->type->typeid == P4T_U32) {
+			u32 *cnt = param->value;
+
+			(*cnt) += cnts_inc;
+		} else {
+			u64 *cnt = param->value;
+
+			(*cnt) += cnts_inc;
+		}
+		write_unlock_bh(&params->params_lock);
+	}
+}
+
+static int
+p4tc_skb_extern_count_pkt_and_byte(struct p4tc_extern_common *common,
+				   struct p4tc_table_counters *counters)
+{
+	p4tc_skb_extern_count_inc(common->params, 2, counters->pkts);
+	p4tc_skb_extern_count_inc(common->params, 3, counters->bytes);
+
+	return 0;
+}
+
+static int
+p4tc_skb_extern_count_pkt(struct p4tc_extern_common *common,
+			  struct p4tc_table_counters *counters)
+{
+	p4tc_skb_extern_count_inc(common->params, 2, counters->pkts);
+
+	return 0;
+}
+
+static int
+p4tc_skb_extern_count_byte(struct p4tc_extern_common *common,
+			   struct p4tc_table_counters *counters)
+{
+	p4tc_skb_extern_count_inc(common->params, 2, counters->bytes);
+
+	return 0;
+}
+
+static int p4tc_extern_count_exec(struct p4tc_extern_common *common,
+				  void *priv)
+{
+	struct p4tc_extern_count_inst *counter_inst;
+	struct p4tc_table_counters *counters = priv;
+	int ret;
+
+	counter_inst = to_count_inst(common->inst);
+	switch (counter_inst->constr_type) {
+	case EXTERN_COUNTER_TYPE_PKTSNBYTES:
+		ret = p4tc_skb_extern_count_pkt_and_byte(common,
+							 counters);
+		break;
+	case EXTERN_COUNTER_TYPE_BYTES:
+		ret = p4tc_skb_extern_count_byte(common, counters);
+		break;
+	case EXTERN_COUNTER_TYPE_PKTS:
+		ret = p4tc_skb_extern_count_pkt(common, counters);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+__bpf_kfunc int
+bpf_p4tc_extern_indirect_count_pktsnbytes(struct __sk_buff *skb_ctx,
+					  struct p4tc_ext_bpf_params *params,
+					  struct p4tc_ext_bpf_res *res)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct p4tc_table_counters counters = { 0 };
+	struct p4tc_extern_count_inst *counter_inst;
+	struct p4tc_extern_common *common;
+	struct p4tc_pipeline *pipeline;
+	int ret = 0;
+
+	common = p4tc_ext_common_elem_get(skb, &pipeline, params);
+	if (IS_ERR(common))
+		return PTR_ERR(common);
+
+	counter_inst = to_count_inst(common->inst);
+	if (counter_inst->constr_type != EXTERN_COUNTER_TYPE_PKTSNBYTES)
+		return -EINVAL;
+
+	counters.pkts = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
+	counters.bytes = qdisc_pkt_len(skb);
+
+	ret = p4tc_skb_extern_count_pkt_and_byte(common, &counters);
+
+	p4tc_ext_common_elem_put(pipeline, common);
+
+	return ret;
+}
+
+__bpf_kfunc int
+bpf_p4tc_extern_indirect_count_bytesonly(struct __sk_buff *skb_ctx,
+					 struct p4tc_ext_bpf_params *params,
+					 struct p4tc_ext_bpf_res *res)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct p4tc_table_counters counters = { 0 };
+	struct p4tc_extern_count_inst *counter_inst;
+	struct p4tc_extern_common *common;
+	struct p4tc_pipeline *pipeline;
+	int ret = 0;
+
+	common = p4tc_ext_common_elem_get(skb, &pipeline, params);
+	if (IS_ERR(common))
+		return PTR_ERR(common);
+
+	counter_inst = to_count_inst(common->inst);
+	if (counter_inst->constr_type != EXTERN_COUNTER_TYPE_BYTES)
+		return -EINVAL;
+
+	counters.bytes = qdisc_pkt_len(skb);
+
+	ret = p4tc_skb_extern_count_byte(common, &counters);
+
+	p4tc_ext_common_elem_put(pipeline, common);
+
+	return ret;
+}
+
+__bpf_kfunc int
+bpf_p4tc_extern_indirect_count_pktsonly(struct __sk_buff *skb_ctx,
+					struct p4tc_ext_bpf_params *params,
+					struct p4tc_ext_bpf_res *res)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct p4tc_table_counters counters = { 0 };
+	struct p4tc_extern_count_inst *counter_inst;
+	struct p4tc_extern_common *common;
+	struct p4tc_pipeline *pipeline;
+	int ret = 0;
+
+	common = p4tc_ext_common_elem_get(skb, &pipeline, params);
+
+	counter_inst = to_count_inst(common->inst);
+	if (counter_inst->constr_type != EXTERN_COUNTER_TYPE_PKTS)
+		return -EINVAL;
+
+	counters.pkts = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
+
+	ret = p4tc_skb_extern_count_pkt(common, &counters);
+
+	p4tc_ext_common_elem_put(pipeline, common);
+
+	return ret;
+}
+
+__diag_pop();
+
+BTF_SET8_START(p4tc_kfunc_ext_counters_set)
+BTF_ID_FLAGS(func, bpf_p4tc_extern_indirect_count_pktsnbytes);
+BTF_ID_FLAGS(func, bpf_p4tc_extern_indirect_count_pktsonly);
+BTF_ID_FLAGS(func, bpf_p4tc_extern_indirect_count_bytesonly);
+BTF_SET8_END(p4tc_kfunc_ext_counters_set)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_ext_counters_set_skb = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_ext_counters_set,
+};
+
+static struct p4tc_extern_ops ext_Counter_ops = {
+	.kind		= "ext_Counter",
+	.size           = sizeof(struct p4tc_extern_count_inst),
+	.id		= EXTERN_COUNTER_ID,
+	.construct      = p4tc_extern_count_constr,
+	.deconstruct    = p4tc_extern_count_deconstr,
+	.exec		= p4tc_extern_count_exec,
+	.owner		= THIS_MODULE,
+};
+
+MODULE_AUTHOR("Mojatatu Networks, Inc");
+MODULE_DESCRIPTION("Counter extern");
+MODULE_LICENSE("GPL");
+
+static int __init counter_init_module(void)
+{
+	int ret = p4tc_register_extern(&ext_Counter_ops);
+
+	if (ret < 0) {
+		pr_info("Failed to register Counter TC extern");
+		return ret;
+	}
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT,
+					&p4tc_kfunc_ext_counters_set_skb);
+	if (ret < 0)
+		goto unregister_counters;
+
+	return ret;
+
+unregister_counters:
+	p4tc_unregister_extern(&ext_Counter_ops);
+	return ret;
+}
+
+static void __exit counter_cleanup_module(void)
+{
+	p4tc_unregister_extern(&ext_Counter_ops);
+}
+
+module_init(counter_init_module);
+module_exit(counter_cleanup_module);
diff --git a/net/sched/p4tc/p4tc_bpf.c b/net/sched/p4tc/p4tc_bpf.c
index 7665c8912..cdb287562 100644
--- a/net/sched/p4tc/p4tc_bpf.c
+++ b/net/sched/p4tc/p4tc_bpf.c
@@ -30,7 +30,8 @@ BTF_ID(struct, p4tc_ext_bpf_params)
 BTF_ID(struct, p4tc_ext_bpf_res)
 
 static struct p4tc_table_entry_act_bpf *
-__bpf_p4tc_tbl_read(struct net *caller_net,
+__bpf_p4tc_tbl_read(struct p4tc_table_counters *counters,
+		    struct net *caller_net,
 		    struct p4tc_table_entry_act_bpf_params *params,
 		    void *key, const u32 key__sz)
 {
@@ -58,6 +59,9 @@ __bpf_p4tc_tbl_read(struct net *caller_net,
 
 	value = p4tc_table_entry_value(entry);
 
+	if (value->counter && value->counter->ops->exec)
+		value->counter->ops->exec(value->counter, counters);
+
 	return value->acts ? p4tc_table_entry_act_bpf(value->acts[0]) : NULL;
 }
 
@@ -70,11 +74,16 @@ bpf_p4tc_tbl_read(struct __sk_buff *skb_ctx,
 		  void *key, const u32 key__sz)
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct p4tc_table_counters counters = {0};
 	struct net *caller_net;
 
+	counters.pkts = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
+	counters.bytes = qdisc_pkt_len(skb);
+
 	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
 
-	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
+	return __bpf_p4tc_tbl_read(&counters, caller_net, params, key,
+				   key__sz);
 }
 
 __bpf_kfunc struct p4tc_table_entry_act_bpf *
@@ -83,11 +92,12 @@ xdp_p4tc_tbl_read(struct xdp_md *xdp_ctx,
 		  void *key, const u32 key__sz)
 {
 	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct p4tc_table_counters counters = {0};
 	struct net *caller_net;
 
 	caller_net = dev_net(ctx->rxq->dev);
 
-	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
+	return __bpf_p4tc_tbl_read(&counters, caller_net, params, key, key__sz);
 }
 
 static int
-- 
2.34.1


