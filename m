Return-Path: <netdev+bounces-36821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012BB7B1E8F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 193DF1C2098F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BF83B78E;
	Thu, 28 Sep 2023 13:35:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952743B781
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 13:35:53 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F1618F
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 06:35:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40572aeb673so101412015e9.0
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695908148; x=1696512948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACmmf/zHEOfOCRNuFkgUQCm+7vCtYlkaQV8tq275BHE=;
        b=UZrakjvInKxQhsOHOypOP1qSH6u6edUXr4zJhmD09gAfX/39/coDugNSylSYs8CFe7
         0oDMaorRSMKDiVNNI6tSvhZC/p5enVUAmBSl8I2ATpStNQsrRkR7Jf6Ys8zR+pWQJgUQ
         2bi1Ax2Ab4Wuxepc7L1JmIJgnVHN6yd1ZURp9LMfw/zQjBNTC7UFupqUeFZmv3UlGfw0
         J4xakpRgn6Ey0QToz68Q8GcKy4EMe0xKl+HRWejyElUz4HTQoVdSJw2msapvOAlsLsYd
         E43AtN4uz/6xqYdf5TCw1oZb+18p99+F5h5QEQziDfh5/LYJU4WaC4pNraK9RTX4Wpn+
         Pbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695908148; x=1696512948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACmmf/zHEOfOCRNuFkgUQCm+7vCtYlkaQV8tq275BHE=;
        b=TQcSV6lVdd7QvWGTjhmrWDrODq2oyE++RQM3vnPcXug1Jw4q4Rx8+zQVa5177Nnmz2
         +ALpLkoCJSO63JKkC0K1221cp1mwtUXW84eEGC3b7SYb4e1jBbhUZPzuenHazr4PZmFs
         PqgfQ39KmZWL1qQHwVynmkvTqV9MAxTQ3rOxs31R6FsmSXILMnoifP1GaKNlt0pF0+nV
         KPG+NBE5Rm0HkJa7wsACAA+1rMk7ag7ksKAoj/oszQzy3dq7Oc4Hx7K4QNYjkAQ34XLw
         FnpppFDh5+3xWzURHtzyc7OTTMswfE+yJ/HQyN7JVoUQCRhEZVwD3bjn5n9vRa7sjecI
         rnfA==
X-Gm-Message-State: AOJu0YzPq/6paJhGvjc+RZIF6/DG4VnLloHT1SrUR/8OhkelE4Q2hoj4
	IJKQo3jMd+Hm70OL9QCJnkpBp4im+laqXg==
X-Google-Smtp-Source: AGHT+IGKk9O1eo3/wC6NxPxkTVEtakiDHivhu5vFoJ8ceKnmZ5UT0EO5PkaSHy7w2oZxeIfRIC9sUg==
X-Received: by 2002:a7b:cb8d:0:b0:406:177e:5df7 with SMTP id m13-20020a7bcb8d000000b00406177e5df7mr1333164wmi.29.1695908148143;
        Thu, 28 Sep 2023 06:35:48 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c378b00b00406443c8b4fsm4011871wmr.19.2023.09.28.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 06:35:47 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	reibax@gmail.com,
	ntp-lists@mattcorallo.com,
	vinicius.gomes@intel.com,
	alex.maftei@amd.com,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: [PATCH net-next v3 0/3] ptp: Support for multiple filtered timestamp event queue readers
Date: Thu, 28 Sep 2023 15:35:41 +0200
Message-Id: <20230928133544.3642650-1-reibax@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On systems with multiple timestamp event channels, there can be scenarios where
multiple userspace readers want to access the timestamping data for various
purposes.

One such example is wanting to use a pps out for time synchronization, and
wanting to timestamp external events with the synchronized time base 
simultaneously.

Timestmp event consumers on the other hand, are often interested in a subset of
the available timestamp channels. linuxptp ts2phc, for example, is not happy if
more than one timestamping channel is active on the device it is reading from.

This patch-set introduces linked lists to support multiple timestamp event queue
consumers, and timestamp event channel filters through IOCTLs.

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Richard Cochran <richardcochran@gmail.com>
---
v3:
  - add this patchset overview file
  - fix use of safe and non safe linked lists for loops
  - introduce new posix_clock private_data and ida object ids for better
    dicrimination of timestamp consumers
  - safer resource release procedures
  - filter application by object id, aided by process id
  - friendlier testptp implementation of event queue channel filters
v2: https://lore.kernel.org/netdev/20230912220217.2008895-1-reibax@gmail.com/
  - fix ptp_poll() return value
  - Style changes to comform to checkpatch strict suggestions
  - more coherent ptp_read error exit routines
  - fix testptp compilation error: unknown type name 'pid_t'
  - rename mask variable for easier code traceability
  - more detailed commit message with two examples
v1: https://lore.kernel.org/netdev/20230906104754.1324412-2-reibax@gmail.com/

