Return-Path: <netdev+bounces-27695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C677CE76
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156CC28150A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138D013AE1;
	Tue, 15 Aug 2023 14:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08569100CE
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 14:52:01 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE5FE5B
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:51:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3179ed1dfbbso4857545f8f.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692111117; x=1692715917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1N4Hd3AqLZkUuDaITXcI5qJOsjG0g5yaVrZWplW+u7g=;
        b=Ih34Y2LPJqS5gTdKIJd4v1iRJ0dpgTIu0CuBlAinpqG5MFW3EM0Yva13Q7l2JklV7c
         NITCJlCyU6K1TtsXB8oHt3IN000vN/E+y2/ehiuhO8DzKBF0V81AKMu9CixwPcaLcZMq
         3XYIdIBqwIDS7VAAdJDSAt7WU1th7usLdJMee6pJ5h9d+VRWezhp+tkZS0rCGRQn6jAY
         sq74In8pH06w8nTu2s2WMvkOWw+/9eJwHoi7xn4J6hnE/jvHRO1Z8t80r/Fo4QGqlUXJ
         IyZehRG9cijb/ZwaDTCOlPA5OP/tHkEDMzSg6ILyXloVTpcgmNwbZY1Z7mKO/Z8zH5Me
         PrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692111117; x=1692715917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1N4Hd3AqLZkUuDaITXcI5qJOsjG0g5yaVrZWplW+u7g=;
        b=KOtdAkWdZfBU7tr/hcBnsPZDQy9evkZBhUwct4Zw3g5qMo6zI9TMy3/zgqW4yRQOrC
         WN4mMzj4b9GWb6b8CI2mWdX6kfl1qMEo/Lh1cp8xaFjceZpUTlSP75GFkrbbT7Ee9KqF
         pIKiAghxFvRVU6jBhKfdUQ+Afhb+9k6gQbqUvnBaV3++kjSAS+MPBywjMlkxZMKJkafu
         IS/qR7w6ORDT02qeoglAZrPLVv7zqo/K/PYUy5nY39mjLEW5U+625IvrqdcDEkMf935N
         7j3f2uN+Df7k861SxrGxgvu7ZqNg01jychwJrvBlTnMYbbpVNr6nlvKDYk+E5r3PJ9qu
         Leow==
X-Gm-Message-State: AOJu0Yw31AwFss8+7QykbbIz82tgEa8AZ7Ckqt45AaJrj+GgeOgLFnhr
	AbfyeBPxLyxU5FgzS2kkxda0NCCsBFKd/V9HZ2Z8aaV6
X-Google-Smtp-Source: AGHT+IGCa3tFvdJjSdAkPmLFWnNFJhwVxAdfeXyBAzhap9YE6jTYr5ZVrNRGgh3mjjrdq3IwYztAbQ==
X-Received: by 2002:adf:ef47:0:b0:319:83e4:bbbf with SMTP id c7-20020adfef47000000b0031983e4bbbfmr2437560wrp.20.1692111117101;
        Tue, 15 Aug 2023 07:51:57 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d500d000000b00317ddccb0d1sm18075243wrt.24.2023.08.15.07.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:51:56 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	shayd@nvidia.com,
	leon@kernel.org
Subject: [patch net-next 0/4] net/mlx5: expose peer SF devlink instance
Date: Tue, 15 Aug 2023 16:51:51 +0200
Message-ID: <20230815145155.1946926-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Currently, the user can instantiate new SF using "devlink port add"
command. That creates an E-switch representor devlink port.

When user activates this SF, there is an auxiliary device created and
probed for it which leads to SF devlink instance creation.

There is 1:1 relationship between E-switch representor devlink port and
the SF auxiliary device devlink instance.

Expose the relation to the user by introducing new netlink attribute
DEVLINK_PORT_FN_ATTR_DEVLINK which contains the devlink instance related
to devlink port function. This is done by patch #3.

Patch #4 implements this in mlx5 driver.

Patches #1 and #2 are just small dependencies.

Examples:
$ devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 106
pci/0000:08:00.0/32768: type eth netdev eth4 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
$ devlink port function set pci/0000:08:00.0/32768 state active
$ devlink port show pci/0000:08:00.0/32768
pci/0000:08:00.0/32768: type eth netdev eth4 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state active opstate attached roce enable nested_devlink auxiliary/mlx5_core.sf.2

Jiri Pirko (4):
  net/mlx5: Disable eswitch as the first thing in mlx5_unload()
  net/mlx5: Lift reload limitation when SFs are present
  devlink: expose peer SF devlink instance
  net/mlx5: SF, Implement peer devlink set for SF representor devlink
    port

 .../net/ethernet/mellanox/mlx5/core/devlink.c | 11 ---
 .../net/ethernet/mellanox/mlx5/core/main.c    |  2 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.h  |  5 ++
 .../mellanox/mlx5/core/sf/dev/driver.c        | 14 ++++
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  | 75 +++++++++++++++++++
 include/linux/mlx5/device.h                   |  1 +
 include/net/devlink.h                         |  4 +
 include/uapi/linux/devlink.h                  |  1 +
 net/devlink/leftover.c                        | 45 ++++++++++-
 9 files changed, 143 insertions(+), 15 deletions(-)

-- 
2.41.0


