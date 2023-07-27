Return-Path: <netdev+bounces-21983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3337658A3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42DB2819CB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C1E1641B;
	Thu, 27 Jul 2023 16:30:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4F1989F
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:30:05 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771A12D4B
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:30:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d2082104a44so1095750276.2
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690475403; x=1691080203;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OFx97IAw9GWb0jhbjG7LGPOVWWrPtutO0w/o9j4T/rs=;
        b=gjRBKZUk/1FwCGORGcQb7HLG51sTApNfL8yaR69GayHih4dTXWBNys6mKacsOO53ph
         Ea7CPNrYYoZg5c47JUqCsW1EHsH4ij/1rherPwgvFnVt9+fje3OvGrVHquhRZFdb7R/7
         V0t0TK6tYAcPSe9XHzW+AH2hstchme1WmtFg2i/0jBRi9kmZdvmS1pWsVAjQ/x8k46q/
         JsyiN3NNTGURGUOON5aXvLNTan7Im5z9Nj6aPNaKkVdcOwimW8AtUCNTTFZgkiQEk3lz
         lIztcdtrayilLdsDqAg7wKXDfTtFohjRWYhc52mOE0Env63Ih6B61/xM6S2C+FEW5a88
         I7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475403; x=1691080203;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFx97IAw9GWb0jhbjG7LGPOVWWrPtutO0w/o9j4T/rs=;
        b=RAUuNB+0zIbN5PnptS0TdkpSxyc3VNr8922Kr/mk7fK4fOU0yA+bI2MRf+MA56nch5
         JQakO0f9ShSpsJeCLESu2jnMX10K1YeOfddYKKeGIpVm+HFou6NS4g7+EpxBMYqsT7gZ
         v/6Zpj2Jt5SrsBGZa9cOe3ary2ghMi87nAckH9DWZXFQD0ly9Ir+TMEtl6lx6WTyjBTv
         aJGv1plkp4H6skYhpQmgSZqX0xB+TMxBDGC1NTonbKbPEzrhAmkQQUG0xXNxjl5g39gt
         tgnGys8lvRxNTD/kz/6RNolKgMhH6WCFXo3yVTrU35vak057LiCUyS8rUV2un2IK9YU+
         lj1Q==
X-Gm-Message-State: ABy/qLauTwmXhIKznIEpGsTCDF6KDXCn+GLBtbsjMsH0/Fs+3HOW9pzi
	SNrHhxSdZRj688rTwyZKDwSJrNzeEOi8Rx4ErbNPKOmoFPg6mEewPYYgI7Zl5i8hNJrSpZ7kCoY
	m+HaKOU3SXU6WiJJUbW4+2TKJUw8xqFG3GZpJNRjCMDbbjYbe1MZk5g==
X-Google-Smtp-Source: APBJJlFWgJQDdzMAzqfeWG5R/FeFYhzcIw7hBgdlQUB22QbByFHwv+MDjxeCC/hTqQkcM9ApYKd2hRU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:1187:0:b0:d16:1f54:75e1 with SMTP id
 129-20020a251187000000b00d161f5475e1mr37231ybr.0.1690475403608; Thu, 27 Jul
 2023 09:30:03 -0700 (PDT)
Date: Thu, 27 Jul 2023 09:29:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230727163001.3952878-1-sdf@google.com>
Subject: [PATCH net-next v2 0/4] ynl: couple of unrelated fixes
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

- spelling of xdp-features
- s/xdp_zc_max_segs/xdp-zc-max-segs/
- expose xdp-zc-max-segs
- add /* private: */
- regenerate headers
- print xdp_zc_max_segs from sample

v2:
- don't put newline after /* private: */ (Jakub)
- use ynl-regen.sh for regen (Jakub)

Stanislav Fomichev (4):
  ynl: expose xdp-zc-max-segs
  ynl: mark max/mask as private for kdoc
  ynl: regenerate all headers
  ynl: print xdp-zc-max-segs in the sample

 Documentation/netlink/specs/netdev.yaml | 5 +++--
 include/uapi/linux/netdev.h             | 3 ++-
 tools/include/uapi/linux/netdev.h       | 3 ++-
 tools/net/ynl/Makefile                  | 1 +
 tools/net/ynl/generated/netdev-user.c   | 6 ++++++
 tools/net/ynl/generated/netdev-user.h   | 2 ++
 tools/net/ynl/samples/netdev.c          | 2 ++
 tools/net/ynl/ynl-gen-c.py              | 1 +
 tools/net/ynl/ynl-regen.sh              | 5 +++++
 9 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog


