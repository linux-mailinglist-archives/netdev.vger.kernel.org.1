Return-Path: <netdev+bounces-234384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F207C1FF3F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 13:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8495B460BED
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD072354AF6;
	Thu, 30 Oct 2025 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ECTTZAZx"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470633FE34;
	Thu, 30 Oct 2025 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826427; cv=none; b=lRbj5axLNX+LbUTANv3vm+ezlFcr2mgxNhTGBmMrA8EpoC6R7YWFq8ltBXXqskjFO3JapHwfn95o2NW9WVagGVFJvthPUUTyJvE6+yfdBLrI49xEhGy9a+RODLQnESQY4T8/CP5HYxyTqHCSsC2oIflJW+7CNCFvSqeKDWnMT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826427; c=relaxed/simple;
	bh=O1sABuBV3CkTOsZ+ygBhKcnhXw9wRSuH++TZAJwphDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JxfSY9VZRL2EQ7HblD4ULdU4iuJUU4al0D77dPgRTS4dmiUdvFjX0KJE6d5An3FzYnnySLndWtjoC/WHEfkOlgKjlLtnXpAZavUxn+AmANb3nHRPXMSGCVVaIJsgGZpoZM1Q3Ktdx5lnnCpnzeUobWMRrmL5BbQx91BjpjEDIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ECTTZAZx; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761826417; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=i49DZd+9b0wsIJOblPo9vPSpfzqkl3X+bO+10YKNWQ8=;
	b=ECTTZAZxDWBaxNo1TqC4sLIjtF1kAN5agfDGtwIltqudo9VlDzbYa0NbXEzitKLhNazgX/JhovX1zw8B6euNQQjAzdYHjrlvjIBB6cuwQa2J+fkYt0QDy2wl54VsR6prv7/3VVSDe3jP+IaB/eBltUbuL3ItbvCqLBNBs3b0YTU=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WrKUnha_1761826410 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 20:13:36 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guwen@linux.alibaba.com
Subject: [PATCH net-next v5 2/2] ptp: add sysfs documentation for Alibaba CIPU PHC driver
Date: Thu, 30 Oct 2025 20:13:14 +0800
Message-Id: <20251030121314.56729-3-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251030121314.56729-1-guwen@linux.alibaba.com>
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds documentation for the sysfs files exposed by the Alibaba
CIPU PHC driver.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 .../ABI/testing/sysfs-ptp-devices-cipu        | 227 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 228 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-ptp-devices-cipu

diff --git a/Documentation/ABI/testing/sysfs-ptp-devices-cipu b/Documentation/ABI/testing/sysfs-ptp-devices-cipu
new file mode 100644
index 000000000000..0abf2fb8eb1e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-ptp-devices-cipu
@@ -0,0 +1,227 @@
+What:           /sys/class/ptp/ptp<N>/device/cipu/ptp_gettm
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of PTP gettime64 and gettimex64 operations performed
+                on the Alibaba CIPU PTP device.
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/ptp_gettm_inval_err
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of failed PTP gettime64 or gettimex64 operations due
+                to invalid timestamp.
+
+                Invalid timestamps are indicated by bit63 (PTP_CIPU_M_TS_ABN)
+                in the timestamp register being set.
+
+                The driver will also trigger device status check when this
+                occurs.
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/ptp_gettm_tout_err
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of failed PTP gettime64 or gettimex64 operations due
+                to register read timeout (exceeding max_lat_ns).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/ptp_gettm_excd_thresh
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of times system time and PHC time offset exceeded
+                the configured threshold (thresh_us).
+
+                This is only recorded and does not affect the returned
+                timestamp.
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/dev_clk_abn
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of atomic clock abnormal events (bit1 set in sync_stat).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/dev_clk_abn_rec
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of recovery from atomic clock abnormal events (bit1
+                cleared in sync_stat after being set).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/dev_maint
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of maintenance events (bit0 set in sync_stat).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/dev_maint_rec
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of recovery from maintenance events (bit0 cleared
+                in sync_stat).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/dev_maint_tout
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of maintenance events that failed to recover within
+                mt_tout_us timeout.
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/dev_busy
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of device busy events (bit4 set in sync_stat).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/dev_busy_rec
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of recovery from device busy events (bit4 cleared
+                in sync_stat).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/dev_err
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of device error events (bit7 set in sync_stat).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/dev_err_rec
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Count of recovery from device error events (bit7 cleared
+                in sync_stat).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/drv_cap
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Driver capabilities bitmask (u32):
+
+                ========  ============================
+                bit 0     support TAI time mode
+                bit 1     support epoch base time mode
+                bit 2     support abnormal event IRQ
+                bit 3     support recovery event IRQ
+                bit 31:4  reserved
+                ========  ============================
+
+                Currently TAI time mode (bit0) is not supported.
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_dev_feat
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Device feature bitmask, same bit definitions as drv_cap.
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_gst_feat
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Feature bitmask negotiated by driver and device, same
+                bit definitions as drv_cap but only features supported
+                by both device and driver are set.
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_drv_ver
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Driver version encoding (u32):
+
+                =========  ===================
+                bit 7:0    subminor version
+                bit 15:8   minor version
+                bit 23:16  major version
+                bit 24     0 for intree driver
+                bit 31:25  reserved
+                =========  ===================
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_env_ver
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Environment encoding (u32):
+
+                =========  =======================
+                bit 7:0    kernel patchlevel
+                bit 15:8   kernel sublevel
+                bit 23:16  kernel version
+                bit 26:24  reserved
+                bit 31:27  0x1F for Linux upstream
+                =========  =======================
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_dev_stat
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Device status (u8):
+
+                =  =========================================
+                0  RESET, device reset
+                1  FEATURE_OK, feature negotiation complete
+                2  DRIVER_OK, fully configured, ready to use
+                =  =========================================
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_sync_stat
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Device sync status bitmask (u8):
+
+                =====  =====================
+                bit 0  maintenance
+                bit 1  atomic clock abnormal
+                bit 4  device busy
+                bit 7  device error
+                =====  =====================
+
+                other bits are reserved.
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_tm_prec_ns
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Time precision reported by device, in nanoseconds (u32).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_epo_base_yr
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Epoch base year used when epoch mode is enabled (u32).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_leap_sec
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Leap seconds offset reported by device, in seconds (u32).
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_max_lat_ns
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Maximum device register read latency tolerated,
+                in nanoseconds (u32).
+
+                Exceeding this is treated as timeout. e.g. see
+                ptp_gettm_tout_err.
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_mt_tout_us
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Maintenance recovery timeout in microseconds (u32).
+
+                If exceeded while maintenance status is set, reported as
+                dev_maint_tout event.
+
+What:           /sys/class/ptp/ptp<N>/device/cipu/reg_thresh_us
+Date:           October 2025
+Contact:        Wen Gu <guwen@linux.alibaba.com>
+Description:
+                Threshold (u32, in microseconds) for acceptable
+                PHC vs system time offset.
+
+                Exceeding this only increments ptp_gettm_excd_thresh
+                counter.
diff --git a/MAINTAINERS b/MAINTAINERS
index b1543fcd12ea..1a4f4a2a96ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -800,6 +800,7 @@ M:	Wen Gu <guwen@linux.alibaba.com>
 M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 L:	netdev@vger.kernel.org
 S:	Supported
+F:	Documentation/ABI/testing/sysfs-ptp-devices-cipu
 F:	drivers/ptp/ptp_cipu.c
 
 ALIBABA ELASTIC RDMA DRIVER
-- 
2.43.5


