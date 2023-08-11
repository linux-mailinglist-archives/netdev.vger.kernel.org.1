Return-Path: <netdev+bounces-26866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970937793B9
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C260F1C2175A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4962AB5B;
	Fri, 11 Aug 2023 15:58:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFAE2AB59
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:58:45 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504830CB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31751d7d96eso1828932f8f.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769521; x=1692374321;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5z06Yt1CFJHs1YhwMNSjlQXmAuLI6Alb07sLJpaCQI=;
        b=xJCN6775UE2xvvdCfcU9nxL8IDOi2W7BPOlO8cfLITsY10Jl4lYn9tzLh1ApTrqUK6
         7+XCKLhY2ktBeLPphniupoolGUs+/dfWQs/qEg2Q3hkIvtKhIVDnTumyt8MH62r7fpZR
         w2f6BIq2Je1kuHlo1d6GxtGgtHpqD30uYrS2tn2t3VHEIHWf1ZE1QjGXOCjGTv9JKJyD
         AmpUxdSRJ6nau3FOBxSa/nXd6exE9gjNVBeKRO71+StNZGdYJlVKqsZ7lBlytoL3kKEf
         RsCj9pE8E0O6AmTZoiXYFYaVsuapbkbE9Tk10e5orWkHzSLsKzkO8V86OFAyb0EjgPNh
         FUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769521; x=1692374321;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5z06Yt1CFJHs1YhwMNSjlQXmAuLI6Alb07sLJpaCQI=;
        b=W9CwV1m4mTgOLVGTIGQ+SzsEvuciXphdibYog3oRrnQS2CHnfVWhfRn3EsBmOHbEYw
         nwTHD5/+Anq14ng8EqtHTliBks7uT0q4lMRYHQwFuy4sGZNVp6hP3gPtP30g8e9q7CTG
         hufDsysU5VCOyp68Y1vVFByKoq5R8OTlgb5bbHZ0JSwf8n0BxLDg7JDsBVmKSolIfANi
         glyqBoIJOzYX+eaJvgonObdoUhbk9td1aNTaGlm5azCmZEg3n9Ec+9xQ1SRlA3Zo35if
         v0U6elrYc38aw+etpGWAKzXeSwQTKCC7AOTOZlnbw0qvgSZ873nCzaA3TERpIk+nl1ts
         rXRA==
X-Gm-Message-State: AOJu0YwyeuiwUuo8hONo9n3HED3orSdoiTiQzDXjT0CaK3Ifzvgb+aMh
	TmI/Hxzg8ANWcaJ+rYeED3LZcw==
X-Google-Smtp-Source: AGHT+IEKCxJXBwUq8BP8z2yfXnYXNYMrJNqbAG3zTrUi+N5aZg4YJiB5Hcu+SF9qIea5qmqKF6HLoA==
X-Received: by 2002:adf:ff92:0:b0:317:ed01:dc48 with SMTP id j18-20020adfff92000000b00317ed01dc48mr1750655wrr.9.1691769520997;
        Fri, 11 Aug 2023 08:58:40 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:40 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 00/14] mptcp: get rid of msk->subflow
Date: Fri, 11 Aug 2023 17:57:13 +0200
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFla1mQC/z2NzQrCMBCEX6Xs2YWmIlhfRTyk2U1dND9kUy2Uv
 rtB0MMcvhn4ZgPlIqxw6TYo/BKVFBuYQwfubuPMKNQYhn449mdjcMlaC9uAkWvLWvE/hVxdxrn
 1RQiTx6AP1GXyz/TG0ZI5ORoduQmaPRf2sn6fr/BzwW3fP33tXeCTAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=FAB0/54LiYDvSFBl1VEoMwafatQAJWGC5dSIRjB6s/8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lquKusHro9FD9KnIi/TEocqWKA86oGQaU2T9
 Frb0jaMRsuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZargAKCRD2t4JPQmmg
 c4cpEAClCe5ahldku+Tc2o7NA4ES2GkoMV+nz0drxdGqRRWfzsdUje8EnyFcHs7XNSfWI5el+5v
 r24QOzS6KvGLCOaDHl8zlrC+rBBPMIDZgs5Zbh0xDMEWWm3fLxwqD1r492lAsQbbTOnHSc5aVNg
 1uceNkDi3rtsh+eWVXL8FFJGy9C8HifkUzlLuBfnZ28xi9kDHjb7Ri7E+MJcW5KsX4wk0YqR0S6
 XaPt/1GRxDhcXQXrjBkcBdfb2azClEbmx+yhl/XS/5Ncd/Tl8qngTSDizSU+LGg+HwGEf+/AdSE
 o008ZCzKRntucdRqqwsBTihH9SClJIcxH3IfR52oYLPZHCsjdl7y1c+K0gM33Z6rqcYzBmepMEE
 u9rOF1VokLKIXWeY+zP1V57KoCWOSgxaYoH4AaZyQVmNFV/8TOZFhFXEs2gwcfsZcV9ngLAwVFx
 3R3rHN608AaqQZWnOEoxLGw874MArmFcINXH6zO/kus1YtpEirv5y2TVTY8I/fjw25+hVHBOeXa
 JIFT2SiCc0l9J6+6aas4YauAHJdq39fCMV35zzRnDS0NkPcQx8RERu/KV8O/2C3s7o2Few0I13P
 pv8HkKWx7vQx1QoBDkggmGDG9HCnU0go4AIU/mR/hcM2VDj+UsqeVxluAHmu/y+mlLwpDKeZK7Y
 lO+60jixOsH9bUQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The MPTCP protocol maintains an additional struct socket per connection,
mainly to be able to easily use tcp-level struct socket operations.

This leads to several side effects, beyond the quite unfortunate /
confusing 'subflow' field name:

- active and passive sockets behaviour is inconsistent: only active ones
  have a not NULL msk->subflow, leading to different error handling and
  different error code returned to the user-space in several places.

- active sockets uses an unneeded, larger amount of memory

- passive sockets can't successfully go through accept(), disconnect(),
  accept() sequence, see [1] for more details.

The 13 first patches of this series are from Paolo and address all the
above, finally getting rid of the blamed field:

- The first patch is a minor clean-up.

- In the next 11 patches, msk->subflow usage is systematically removed
  from the MPTCP protocol, replacing it with direct msk->first usage,
  eventually introducing new core helpers when needed.

- The 13th patch finally disposes the field, and it's the only patch in
  the series intended to produce functional changes.

The last and 14th patch is from Kuniyuki and it is not linked to the
previous ones: it is a small clean-up to get rid of an unnecessary check
in mptcp_init_sock().

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/290

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Kuniyuki Iwashima (1):
      mptcp: Remove unnecessary test for __mptcp_init_sock()

Paolo Abeni (13):
      mptcp: avoid unneeded mptcp_token_destroy() calls
      mptcp: avoid additional __inet_stream_connect() call
      mptcp: avoid subflow socket usage in mptcp_get_port()
      net: factor out inet{,6}_bind_sk helpers
      mptcp: mptcp: avoid additional indirection in mptcp_bind()
      net: factor out __inet_listen_sk() helper
      mptcp: avoid additional indirection in mptcp_listen()
      mptcp: avoid additional indirection in mptcp_poll()
      mptcp: avoid unneeded indirection in mptcp_stream_accept()
      mptcp: avoid additional indirection in sockopt
      mptcp: avoid ssock usage in mptcp_pm_nl_create_listen_socket()
      mptcp: change the mpc check helper to return a sk
      mptcp: get rid of msk->subflow

 include/net/inet_common.h |   2 +
 include/net/ipv6.h        |   1 +
 net/ipv4/af_inet.c        |  46 ++++++-----
 net/ipv6/af_inet6.c       |  10 ++-
 net/mptcp/pm_netlink.c    |  30 +++----
 net/mptcp/protocol.c      | 194 ++++++++++++++++++++++------------------------
 net/mptcp/protocol.h      |  15 ++--
 net/mptcp/sockopt.c       |  65 ++++++++--------
 8 files changed, 186 insertions(+), 177 deletions(-)
---
base-commit: 80f9ad046052509d0eee9b72e11d0e8ae31b665f
change-id: 20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-9ad15cd9cdcb

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>


