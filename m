Return-Path: <netdev+bounces-12416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643F57376AE
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 23:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0371C20D18
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107F182C1;
	Tue, 20 Jun 2023 21:34:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17752AB30
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 21:34:22 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C488170D
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 14:34:21 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7623fdb3637so355301385a.2
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687296860; x=1689888860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ku9DbHiqCSX6EpSCfcS9Wvmori/oVdLLmCG3G6BgDWU=;
        b=MXCtAHvJMTEkLVUKC+HMi5pGaxXySC3FYOQ27vBcZBOId+IaO60zYFqTzXtggjuWfX
         wa+UEpDkc2Yjnn2Cwa9ltiB8LhbBlpnJS3bE4zz7b9v5j5JZBF66edKnx4abGElTTUKS
         rmqsy9teasCt/9xB5YK0MCyf4tjO6DBxxaSuCAm+5aeSlysIUGPD93Fn09MpHGPydNkE
         b2mi7apW0NoEy8ZJ+VytDreA8JhDL9XV9kHInvWQFDx02zMt8TIX3v0iuY40rcRIO5Mp
         cqXPDBxtjUiE6ifidFOgBjzBIDt9J5i4uqqORuJzOmZqeaIfaqTVpf31d7aWiQoHDuRx
         lkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687296860; x=1689888860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ku9DbHiqCSX6EpSCfcS9Wvmori/oVdLLmCG3G6BgDWU=;
        b=NyqbLtSkWiI5vT3NUmBiK+S4z+7h6WlEm6qmi/CQD2Xzm+QNErxHhx/2aRTjr/LVqb
         UYoMTIhcnSgBHTt7723kaAF8VpRnxOa/eSTJObuVZt1iz3i0jExPj4eAsR01O2Gb6RL2
         KEpg+h3TxYMMn37NRS5FlW8/Jp6UucV++0kWEPqAzmAMSqQcV8soCpGiV7p7cs2hLf0w
         EDx3lx2/riC9Tn1EyZitLSZYfZ5GRZYwwiTdDO0G3HDzJwWbGQ6Hducf2wkRwep8ZMyH
         ca6m81HFgfG34bqCug9QLadSM3uLliaT7KwneJU5Dj5Vq82IAujBhUUmaCCe9lnaDYqu
         E5nA==
X-Gm-Message-State: AC+VfDwQzW//5CvJxv9otHDI2afRBzU5k9t6aGgUlJthk8o03uvr/k4D
	lGhPjLL1LIncriXeB9X2nnOnqO0y184YTw==
X-Google-Smtp-Source: ACHHUZ64C2s+qJpqeQoB1kx49F4vrXEVzprOPfOHeZpo9D6XnzFebUM0H9xUEjdss5EPSrwpig1W8Q==
X-Received: by 2002:a05:620a:2b46:b0:762:3c9b:d3c7 with SMTP id dp6-20020a05620a2b4600b007623c9bd3c7mr13849385qkb.18.1687296859990;
        Tue, 20 Jun 2023 14:34:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:eae5:6acd:8444:936b])
        by smtp.gmail.com with ESMTPSA id s131-20020a815e89000000b0057068c6924esm389521ywb.75.2023.06.20.14.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:34:19 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v3 0/2] Fix missing synack in BPF cgroup_skb filters
Date: Tue, 20 Jun 2023 14:32:25 -0700
Message-Id: <20230620213227.180421-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I cross-post this patchset from the BPF list since people from this
mailing list may interest in.  Sorry for not including this list at
the beginning!  Original post in the BPF list could be found at
https://lore.kernel.org/all/20230620171409.166001-1-kuifeng@meta.com/

TCP SYN/ACK packets of connections from processes/sockets outside a
cgroup on the same host are not received by the cgroup's installed
cgroup_skb filters.

There were two BPF cgroup_skb programs attached to a cgroup named
"my_cgroup".

    SEC("cgroup_skb/ingress")
    int ingress(struct __sk_buff *skb)
    {
        /* .... process skb ... */
        return 1;
    }

    SEC("cgroup_skb/egress")
    int egress(struct __sk_buff *skb)
    {
        /* .... process skb ... */
        return 1;
    
    }

We discovered that when running the command "nc -6 -l 8000" in
"my_group" and connecting to it from outside of "my_cgroup" with the
command "nc -6 localhost 8000", the egress filter did not detect the
SYN/ACK packet. However, we did observe the SYN/ACK packet at the
ingress when connecting from a socket in "my_cgroup" to a socket
outside of it.

We came across BPF_CGROUP_RUN_PROG_INET_EGRESS(). This macro is
responsible for calling BPF programs that are attached to the egress
hook of a cgroup and it skips programs if the sending socket is not the
owner of the skb. Specifically, in our situation, the SYN/ACK
skb is owned by a struct request_sock instance, but the sending
socket is the listener socket we use to receive incoming
connections. The request_sock is created to manage an incoming
connection.

It has been determined that checking the owner of a skb against
the sending socket is not required. Removing this check will allow the
filters to receive SYN/ACK packets.

To ensure that cgroup_skb filters can receive all signaling packets,
including SYN, SYN/ACK, ACK, FIN, and FIN/ACK. A new self-test has
been added as well.

Changes from v2:

 - Remove redundant blank lines.

Changes from v1:

 - Check the number of observed packets instead of just sleeping.

 - Use ASSERT_XXX() instead of CHECK()/

[v1] https://lore.kernel.org/all/20230612191641.441774-1-kuifeng@meta.com/
[v2] https://lore.kernel.org/all/20230617052756.640916-2-kuifeng@meta.com/

Kui-Feng Lee (2):
  net: bpf: Always call BPF cgroup filters for egress.
  selftests/bpf: Verify that the cgroup_skb filters receive expected
    packets.

 include/linux/bpf-cgroup.h                    |   2 +-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  12 +
 tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
 tools/testing/selftests/bpf/cgroup_tcp_skb.h  |  35 ++
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 399 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_tcp_skb.c      | 382 +++++++++++++++++
 6 files changed, 830 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c

-- 
2.34.1


