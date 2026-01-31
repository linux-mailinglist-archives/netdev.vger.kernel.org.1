Return-Path: <netdev+bounces-255457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP7UFDYufmlLWQIAu9opvQ
	(envelope-from <netdev+bounces-255457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:30:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 907B9C3017
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C8423014669
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2C7339853;
	Sat, 31 Jan 2026 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="up6oGSR0"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F7F32D0EF
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877042; cv=none; b=WSUgBAa7s3tN6Vhd8TgdET0AeBoG59e6C0tqT6qZPw1RqB+4VjrMCN7UyU8NfwFXVJniv2qC598qjbxeb6Ke4DEKYtgPzvvonIn1n5QayOlVsk3e2ryUI3/43X36kSBt5IdQl+M82Mkc9OlpBugPHoCaRpxRCKK1sp4AB9MYm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877042; c=relaxed/simple;
	bh=osA1pyvQjT5obJ61HgNuHe+4VMk5oDw4WwCvI/6XkLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLt1UnvX/0C8KJk8lViU/lvDCWDIgQP1ntkPwFT1aWUcKBgvGuLxlAkr4guGLpmH6Ol4FHaQCYTHecJGxov/UVBs86reWUv++yS2GMk5Jy46s/gMbQNHQRNEdVx5Hhe7xxFp5e1p6zH+wEiIQSdyqYJGsWhhffCGECtz93r/YeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=up6oGSR0; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60VGUcS2039137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Feb 2026 01:30:39 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=/LaTNBzU1ZqwGjSbsitnVGu2AjeEHf5402YTnnjokBU=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769877039; v=1;
        b=up6oGSR0BnRs59uNdGoleUeQWdyRDQ1MElhF4/8+iH5g+NjR6xMa5NPi0uQGc0Lc
         Sn8X6xDFmfx5RnABSQEnBr4vEdlmxHqxr0YlNjIVnne6sy2f7rW1iip0mRLmN+wO
         bfT+FxNqbgTnU9MNTQu2DFS1eAzeDKSVN+S5m6PvR82Cux/11vQhSlQxGCQvXn3O
         1cU6d4yMVvlHPgabxes/UyCw7oJWaeuSsSMrkmvNzj6kpBvLx2ttCdP06MLfDP/N
         i1mVIfqUHxCV3TJrP0J05yxRgfRcFqQxtFC5Hx+XWOcO85GD1EJAtr2m9A7s7LXw
         tT37C7Wd08/g9ZsTVq/mfw==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vitaly Lifshits <vitaly.lifshits@intel.com>,
        Simon Horman <horms@kernel.org>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v2 iwl-next 0/3] igc: add RSS key get/set support
Date: Sat, 31 Jan 2026 16:29:35 +0000
Message-ID: <20260131163037.88108-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-255457-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:mid,enjuk.jp:dkim]
X-Rspamd-Queue-Id: 907B9C3017
X-Rspamd-Action: no action

This series adds ethtool get/set support for the RSS hash key.

Without patch:
 # ethtool -x $DEV | grep key -A1
 RSS hash key:
 Operation not supported
 # ethtool -X $DEV hkey be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef
 Cannot set RX flow hash configuration:
  Hash key setting not supported

With patch:
 # ethtool -x $DEV | grep key -A1
 RSS hash key:
 dd:7c:1f:06:1a:42:dc:e5:7e:90:2c:48:aa:3f:5d:5a:d7:da:ec:44:3e:3f:df:78:89:1e:3c:68:2e:59:da:a0:23:5a:32:5c:cf:5e:7e:7b
 # ethtool -X $DEV hkey be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef
 # ethtool -x $DEV | grep key -A1
 RSS hash key:
 be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef

Also tested with rss_api.py and toeplitz.py.
 # ./tools/testing/selftests/drivers/net/hw/rss_api.py | grep rss_api.test_rxfh_nl_set_key
 ok 6 rss_api.test_rxfh_nl_set_key
 # tools/testing/selftests/drivers/net/hw/toeplitz.py | grep "# Totals"
 # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

Notes:
Since the 2/3 patch is unchanged, I preserved Tested-by and Reviewed-by
tags for the patch.

Changes:
  v2:
    - call netdev_rss_key_fill() in igc_sw_init(), not in
      igc_setup_mrqc()
    - add documentation for igc_write_rss_key()
    - drop has_user_rss_key flag, since rss_key is never cleared except
      for user operations
    - change email address from @amazon.com to @enjuk.jp
  v1: https://lore.kernel.org/intel-wired-lan/20251025150136.47618-1-enjuk@amazon.com/

Kohei Enju (3):
  igc: prepare for RSS key get/set support
  igc: expose RSS key via ethtool get_rxfh
  igc: allow configuring RSS key via ethtool set_rxfh

 drivers/net/ethernet/intel/igc/igc.h         |  3 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 67 +++++++++++++++-----
 drivers/net/ethernet/intel/igc/igc_main.c    |  8 +--
 3 files changed, 57 insertions(+), 21 deletions(-)

-- 
2.51.0


