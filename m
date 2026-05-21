Return-Path: <netdev+bounces-290523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBhGCjEuD2r+HQYAu9opvQ
	(envelope-from <netdev+bounces-290523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:09:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C2A5A8EE8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2A0231911AD
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB20277CA5;
	Thu, 21 May 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="LbcwQu88"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484D23BCEE
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376103; cv=none; b=FEfjNhABxxCegy3CjR/yzsdv5vUe38XrjoaOLjQqOlAwE1YzkNu7D/VQtC2tjocunYMGcBJHj110ARTgIfj8gDUv2EqzbPzrw0unoepL/LCa89Q+b0KpG41JNkrizS0xuS/zNuafcoLE4hM3a6JA5RZ5XUn1TgPg6FMF79tsyvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376103; c=relaxed/simple;
	bh=OEPQOe7VPkCYeUN0fMBjKD0J61bU7391RwDg/hXAE7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MO6WGNPrAx4yvm0vUdhWVfXSNSK9Y6js1Oy4DxWhnshRDCE9rBR2WwEtRij5r00WJaB/JD1sGO8ZzqhFqfolFySfIvmOkfIAEIOaUuLjCvpL4Ri7xpwULUzStAyYXJhFaC2MtLXsUpao9nhmtdqBncrVAbNlMHoQA5lG+aBOk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=LbcwQu88; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-6314d2e31d6so2128964137.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779376100; x=1779980900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dufChQmfBmIYymq91soBr9mxGxyqJ2a2wQN8zGScCUQ=;
        b=LbcwQu884TNrVbIGtWYnkZcMwvgpLfO7xYRf+jt0BpUmky4s4V/WWx9fmVWliwXyIO
         282m1Bso/Y+GCMAY7+iEhhD4mKFQ9Fv99YlwsILxJEwYsY2+JPQuTyINGdM44+xc9+We
         z+6Eu/T6RTGrvWzNgO8IkOS92LoEM80Knuhnr4qVrj6yXpEMlBmf9ZzJSPRVhlPhsGiQ
         gT834RAffoAFcWgx2RxDHEQ+Ya+5cO7H7w5Lx5PqzjULf6+fjOhAQeygwz6TyM7sE2ws
         4PDF7Tfcy03jKlX+3nL4CC2e41hF+mtQ2p9Oz5NAsW4VHb6U6Z1bCZyj6GgMRqxT7UWP
         r+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779376100; x=1779980900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dufChQmfBmIYymq91soBr9mxGxyqJ2a2wQN8zGScCUQ=;
        b=Ie87/q9kHMAdek3ynr9NhinA5mq8PChZNctPjzsl7bYHeEhAVdgfyVd5YHWpNFJpop
         b0YF5rh8BKzPbOAf7cVERWHlieZ1qjvTnGN8rT0ILldDwPi/PizYA1W4z0QcjtDedXjb
         iRwmLiwuwa0CR5HDbcJGkNGfwvQ6hNhdThEa8T8RtW/UnRI2yQhposZ6IKmSFXu0RFrf
         KoIEEbb1iRJLzpKqM6O/xGQjOB+GDqQpEZY/7MXj4IAMlG18fY/zWJA0wjvtCjMMNpzW
         3HaMQhpb0+biC5Hj4teMvgrSdRnE770DhcZKZHmb9O1ITYcHdx6JQ1hG7/21C1u7HvYe
         VmXw==
X-Gm-Message-State: AOJu0YzbklLpE0mXeqo+QdrzrebhFGen6XgbM4/ARNdvGC91ikDnnkX8
	v0xRumF9V7g4amaJKx1rgQgdCipngtiZys3DfzSZ0t9bM8iK5jP/8FSDGQ18+I9nNg==
X-Gm-Gg: Acq92OEI6q/ZzlVAZwg8DBPO2D6M6kH9pDajk0NfguPmDBQTqRLb8nY3BtcAwUBh0Ql
	rFboZFXJOKBVpSzYY2mpTXPZ+uv/AM5LoQkG2dN9aKKdHL6rcza96DvBQjWDqBW7WYA5ls3IH6h
	wF0sg5fQmQovUjEVvPS0a7XWTqsL3OG+rOZGbo8Xh6vLEE5cywq6JNbpaq59sK/73zDMkmy9GBp
	rR6lNWrkunoLCnbzz4k9Nnf4GdCyH7+oeQNEm+a/LmInRmRaTH0NvXVIqbsMCT3iR8d+oov8T5r
	idJCVmz82pL8G4WTsTPQTSZQt6FUgKl8LwBGyadJbIrPlHQgLRfgMOsECRo8lW5J8i5zuPDAk60
	JMVqdr9Ip2sA793pkTT2nehYpgFSwsCr/xzkTdaMppJpeLkgwYijCsqzxn7zGXHFTB8FR1dR1qC
	ch4xNv4IluP+fzxOoR7/oXtvTVkk7S+yepUhifaS6c2HjCCg==
X-Received: by 2002:a67:e7cc:0:b0:62f:357a:3297 with SMTP id ada2fe7eead31-6738d46402dmr1986197137.5.1779376100139;
        Thu, 21 May 2026 08:08:20 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-679fa70c8d7sm881114137.11.2026.05.21.08.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:08:18 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	pctammela@mojatatu.com
Subject: [PATCH net-next 1/2] selftests/tc-testing: Add support for ifb devices
Date: Thu, 21 May 2026 12:08:10 -0300
Message-ID: <20260521150811.1896373-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-290523-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:mid,mojatatu.com:email,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 77C2A5A8EE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for ifb devices in tdc so that tests with the nsPlugin are
able to use it when necessary.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tools/testing/selftests/tc-testing/config                 | 1 +
 tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py | 7 +++++++
 tools/testing/selftests/tc-testing/tdc.py                 | 3 +++
 tools/testing/selftests/tc-testing/tdc_config.py          | 1 +
 4 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index c20aa16b1d63..0e5618be0335 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -4,6 +4,7 @@
 
 CONFIG_DUMMY=y
 CONFIG_VETH=y
+CONFIG_IFB=y
 
 #
 # Core Netfilter Configuration
diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index bb19b8b76d3b..0bece7c74f07 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -120,6 +120,7 @@ class SubPlugin(TdcPlugin):
         dev0 = self.args.NAMES["DEV0"];
         dev1 = self.args.NAMES["DEV1"];
         dummy = self.args.NAMES["DUMMY"];
+        ifb = self.args.NAMES['IFB']
 
         if self.args.verbose:
             print('{}._nl_ns_create'.format(self.sub_class))
@@ -129,6 +130,7 @@ class SubPlugin(TdcPlugin):
         with IPRoute() as ip:
             ip.link('add', ifname=dev1, kind='veth', peer={'ifname': dev0, 'net_ns_fd':'/proc/1/ns/net'})
             ip.link('add', ifname=dummy, kind='dummy')
+            ip.link('add', ifname=ifb, kind='ifb')
             ticks = 20
             while True:
                 if ticks == 0:
@@ -136,8 +138,10 @@ class SubPlugin(TdcPlugin):
                 try:
                     dev1_idx = ip.link_lookup(ifname=dev1)[0]
                     dummy_idx = ip.link_lookup(ifname=dummy)[0]
+                    ifb_idx = ip.link_lookup(ifname=ifb)[0]
                     ip.link('set', index=dev1_idx, state='up')
                     ip.link('set', index=dummy_idx, state='up')
+                    ip.link('set', index=ifb_idx, state='up')
                     break
                 except:
                     time.sleep(0.1)
@@ -169,8 +173,11 @@ class SubPlugin(TdcPlugin):
         cmds.append(self._replace_keywords('link set $DEV1 netns {}'.format(ns)))
         cmds.append(self._replace_keywords('link add $DUMMY type dummy'.format(ns)))
         cmds.append(self._replace_keywords('link set $DUMMY netns {}'.format(ns)))
+        cmds.append(self._replace_keywords('link add $IFB type ifb'))
+        cmds.append(self._replace_keywords('link set $IFB netns {}'.format(ns)))
         cmds.append(self._replace_keywords('netns exec {} $IP link set $DEV1 up'.format(ns)))
         cmds.append(self._replace_keywords('netns exec {} $IP link set $DUMMY up'.format(ns)))
+        cmds.append(self._replace_keywords('netns exec {} $IP link set $IFB up'.format(ns)))
         cmds.append(self._replace_keywords('link set $DEV0 up'.format(ns)))
 
         if self.args.device:
diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index 81b4ac3f050c..511d66c36a2a 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -378,6 +378,7 @@ def run_one_test(pm, args, index, tidx):
     dev0 = NAMES['DEV0']
     dev1 = NAMES['DEV1']
     dummy = NAMES['DUMMY']
+    ifb = NAMES['IFB']
     result = True
     tresult = ""
     tap = ""
@@ -414,6 +415,7 @@ def run_one_test(pm, args, index, tidx):
     NAMES['DEV0'] = '{}id{}'.format(NAMES['DEV0'], tidx['id'])
     NAMES['DEV1'] = '{}id{}'.format(NAMES['DEV1'], tidx['id'])
     NAMES['DUMMY'] = '{}id{}'.format(NAMES['DUMMY'], tidx['id'])
+    NAMES['IFB'] = '{}id{}'.format(NAMES['IFB'], tidx['id'])
 
     pm.call_pre_case(tidx)
     prepare_env(tidx, args, pm, 'setup', "-----> prepare stage", tidx["setup"])
@@ -474,6 +476,7 @@ def run_one_test(pm, args, index, tidx):
     NAMES['DEV0'] = dev0
     NAMES['DEV1'] = dev1
     NAMES['DUMMY'] = dummy
+    NAMES['IFB'] = ifb
 
     return res
 
diff --git a/tools/testing/selftests/tc-testing/tdc_config.py b/tools/testing/selftests/tc-testing/tdc_config.py
index 9488b03cbc2c..cd0bd42f05a5 100644
--- a/tools/testing/selftests/tc-testing/tdc_config.py
+++ b/tools/testing/selftests/tc-testing/tdc_config.py
@@ -17,6 +17,7 @@ NAMES = {
           'DEV1': 'v0p1',
           'DEV2': '',
           'DUMMY': 'dummy1',
+          'IFB': 'ifbtdc0',
           'ETHTOOL': '/usr/sbin/ethtool',
 	  'ETH': 'eth0',
           'BATCH_FILE': './batch.txt',
-- 
2.54.0


