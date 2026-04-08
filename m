Return-Path: <netdev+bounces-276317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP7bNSX/1Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:09:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996793B7E84
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 934F0301F2B2
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E863376BD7;
	Wed,  8 Apr 2026 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWoDBpEt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91AC371CF5
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632150; cv=none; b=ZoZXy1OpT86cPfok2GwHAtXnos7GO7lE9Lr4dOOOIzNpMtBQGKkMF4JJzHmb+ZeJvPE8/i16zpyxZb8Ttvmm/QCB+OiXw2Oh9wmggpfRD61Iy56Rsd5u6UbuUdhXcnnnBt/JFwLLKBWbl43gnZC725aj1CYNZ+AzpQwQrC4mWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632150; c=relaxed/simple;
	bh=nKXB41y7VDENzvnPywjZ/CEAPXQdNhNRJWnavISbbq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVEFp6+LcnOklJArQjMlxePYJPWhkCMEXLMYq+I8DKANlLZ4VyLCqidyDZPzCMqBRMpoy3y0iyGX/mI2mskamPTv3q85j6FM3g7cU/w91U5RWIUKH3gKhpvDGTv/WdpvJQtFUxCkIoNC0XEMSPeM9xr7LIamkcHme9G4enxl+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWoDBpEt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab39b111b9so25553185ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775632148; x=1776236948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDB8ejXWyf/utgwTbcAlTNKIHKdTUYoTuRoM9G0Gl9g=;
        b=fWoDBpEt/lPxkzEeSLWg+3wYZIJaCaSXJj1XZ9LwB5xtomEefTBigyDUTH+Naf1/j9
         lrFkFDGSht8JEnW6YUAo2613eoUeOdVwbs4OCwiz0+rByDar0EEDENlv2y9bP353yPnt
         FSURRwMh7zTAq9j37OBxs9UQP766pY5+0Sb3kiI4psNdhHgj9BgF8cbFcIUJWkPDQj/7
         nbjDQQG5cakFjMOHF9tT1y3CJK246QY368ygSabwDxhBeCkl15ft8U0Z88QA7bfWu8lP
         Y0GU4++I4ug4pUTeIUn1cY2iMIm0J45xC/BbNBmlWMQX/zxGVUkXz+EGNC3hQMloZrJI
         /fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775632148; x=1776236948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IDB8ejXWyf/utgwTbcAlTNKIHKdTUYoTuRoM9G0Gl9g=;
        b=O635hLG3nC2ZUiyQMn/gHu4iLOq3bQGJzfvKbbrE3+ch/hqckK24sbf+Ygaq8h6A/F
         JryVR3Lm6/WHnbAj/ePeGzPXCcWu8GT81I0RffuzMz2NeIlAxWjdww/ikorbGqm5JiRJ
         6YXbntPJyse8Cqmh15BmcoopReMBRY13+hks+qD0xeDchXooETWumumHSBgrH6kN8VXe
         /cdLZsqNcyaf/qJl8rA4SDwSEQLfakbVi2Qldwx3MiphX/4Q+JRLjVE4S4lmEiRABCjK
         XstoD0vRICut02vyex+LbO2O5ga3CGC9s5rdJh9+z786zI2aIdZfVE0rSFhWtrxDPEa/
         xqTA==
X-Gm-Message-State: AOJu0YyE+ueR3dnSd3ZrZ9/fbL7EtFYkfUih4kkGR+sgJQp1gjmYyk5Z
	qUBNGEMhAvsXDi+atDpzbLxYM2rzEuCBHi1W/TXhnq/IqkK8jCiXUP1y
X-Gm-Gg: AeBDievYUDOBwu38ewAjBhgBTUS3KBDdTpnxagM/SVnhAxIjCpdlPqaJ2bpApapRGBp
	yUXcX3eRBZRlxwytDaZ6W3iiEHFddWQ1iGmgu1LM4b3GRDdrKJJVShYbRPVb532Vv9PhSUFCznz
	ziI2LsWtwMIjR4Tcn3n60DqN3fEIa9eETZQtv54xz84qao/YKXuZV1uJ3uikpe6iQahZLw1FPo5
	pOJohOKZ9xCTXL1PznGeP9GYg0zPv5x75evKrDPRgbT1YKTNObp9AuuDdOEIbzfU6oD5Pdaadeb
	T32soPNvjqk1vgPiLZwN4XpnPBcPC2pwAhM/WhNOno7lhhhmlUjz/tuYCqE0QKDiiVljIEqehKT
	2PcY4KChTybf4UikpHOO8GopVqXFyNUwiZfcrl4PBPK0oTPaY70sNiwOOH783fIyfCEx2zc9Hlf
	hcRvS/QZ/7qBjKlMtVcH4MkptqkdO5ivNOjSX6bPf+OJVO8ltgTL1/TTbA8MQ=
X-Received: by 2002:a17:902:ef48:b0:2b2:527d:103 with SMTP id d9443c01a7336-2b2817cc0d9mr187696245ad.43.1775632148297;
        Wed, 08 Apr 2026 00:09:08 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749b66aasm202917785ad.68.2026.04.08.00.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:09:07 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 08 Apr 2026 15:08:50 +0800
Subject: [PATCH net-next v2 2/5] tools: ynl: ethtool: use doit instead of
 dumpit for per-device GET
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-ynl_ethtool-v2-2-7623a5e8f70b@gmail.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
In-Reply-To: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-276317-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 996793B7E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename the local helper doit() to do_set() and dumpit() to do_get() to
better reflect their purpose.

Convert do_get() to use ynl.do() with an explicit device header instead
of ynl.dump() followed by client-side filtering. This is more efficient
as the kernel only processes and returns data for the requested device,
rather than dumping all devices across the netns.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/tests/ethtool.py | 68 ++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/tools/net/ynl/tests/ethtool.py b/tools/net/ynl/tests/ethtool.py
index 6eeeb867edcf..63854d21818c 100755
--- a/tools/net/ynl/tests/ethtool.py
+++ b/tools/net/ynl/tests/ethtool.py
@@ -84,9 +84,9 @@ def print_speed(name, value):
     speed = [ k for k, v in value.items() if v and speed_re.match(k) ]
     print(f'{name}: {" ".join(speed)}')
 
-def doit(ynl, args, op_name):
+def do_set(ynl, args, op_name):
     """
-    Prepare request header, parse arguments and doit.
+    Prepare request header, parse arguments and do a set operation.
     """
     req = {
         'header': {
@@ -97,26 +97,24 @@ def doit(ynl, args, op_name):
     args_to_req(ynl, op_name, args.args, req)
     ynl.do(op_name, req)
 
-def dumpit(ynl, args, op_name, extra=None):
+def do_get(ynl, args, op_name, extra=None):
     """
-    Prepare request header, parse arguments and dumpit (filtering out the
-    devices we're not interested in).
+    Prepare request header and get info for a specific device using doit.
     """
     extra = extra or {}
-    reply = ynl.dump(op_name, { 'header': {} } | extra)
+    req = {'header': {'dev-name': args.device}}
+    req['header'].update(extra.pop('header', {}))
+    req.update(extra)
+
+    reply = ynl.do(op_name, req)
     if not reply:
         return {}
 
-    for msg in reply:
-        if msg['header']['dev-name'] == args.device:
-            if args.json:
-                pprint.PrettyPrinter().pprint(msg)
-                sys.exit(0)
-            msg.pop('header', None)
-            return msg
-
-    print(f"Not supported for device {args.device}")
-    sys.exit(1)
+    if args.json:
+        pprint.PrettyPrinter().pprint(reply)
+        sys.exit(0)
+    reply.pop('header', None)
+    return reply
 
 def bits_to_dict(attr):
     """
@@ -181,15 +179,15 @@ def main():
         return
 
     if args.set_eee:
-        doit(ynl, args, 'eee-set')
+        do_set(ynl, args, 'eee-set')
         return
 
     if args.set_pause:
-        doit(ynl, args, 'pause-set')
+        do_set(ynl, args, 'pause-set')
         return
 
     if args.set_coalesce:
-        doit(ynl, args, 'coalesce-set')
+        do_set(ynl, args, 'coalesce-set')
         return
 
     if args.set_features:
@@ -198,20 +196,20 @@ def main():
         return
 
     if args.set_channels:
-        doit(ynl, args, 'channels-set')
+        do_set(ynl, args, 'channels-set')
         return
 
     if args.set_ring:
-        doit(ynl, args, 'rings-set')
+        do_set(ynl, args, 'rings-set')
         return
 
     if args.show_priv_flags:
-        flags = bits_to_dict(dumpit(ynl, args, 'privflags-get')['flags'])
+        flags = bits_to_dict(do_get(ynl, args, 'privflags-get')['flags'])
         print_field(flags)
         return
 
     if args.show_eee:
-        eee = dumpit(ynl, args, 'eee-get')
+        eee = do_get(ynl, args, 'eee-get')
         ours = bits_to_dict(eee['modes-ours'])
         peer = bits_to_dict(eee['modes-peer'])
 
@@ -232,18 +230,18 @@ def main():
         return
 
     if args.show_pause:
-        print_field(dumpit(ynl, args, 'pause-get'),
+        print_field(do_get(ynl, args, 'pause-get'),
                 ('autoneg', 'Autonegotiate', 'bool'),
                 ('rx', 'RX', 'bool'),
                 ('tx', 'TX', 'bool'))
         return
 
     if args.show_coalesce:
-        print_field(dumpit(ynl, args, 'coalesce-get'))
+        print_field(do_get(ynl, args, 'coalesce-get'))
         return
 
     if args.show_features:
-        reply = dumpit(ynl, args, 'features-get')
+        reply = do_get(ynl, args, 'features-get')
         available = bits_to_dict(reply['hw'])
         requested = bits_to_dict(reply['wanted']).keys()
         active = bits_to_dict(reply['active']).keys()
@@ -270,7 +268,7 @@ def main():
         return
 
     if args.show_channels:
-        reply = dumpit(ynl, args, 'channels-get')
+        reply = do_get(ynl, args, 'channels-get')
         print(f'Channel parameters for {args.device}:')
 
         print('Pre-set maximums:')
@@ -290,7 +288,7 @@ def main():
         return
 
     if args.show_ring:
-        reply = dumpit(ynl, args, 'channels-get')
+        reply = do_get(ynl, args, 'channels-get')
 
         print(f'Ring parameters for {args.device}:')
 
@@ -319,7 +317,7 @@ def main():
         print('NIC statistics:')
 
         # TODO: pass id?
-        strset = dumpit(ynl, args, 'strset-get')
+        strset = do_get(ynl, args, 'strset-get')
         pprint.PrettyPrinter().pprint(strset)
 
         req = {
@@ -338,7 +336,7 @@ def main():
           },
         }
 
-        rsp = dumpit(ynl, args, 'stats-get', req)
+        rsp = do_get(ynl, args, 'stats-get', req)
         pprint.PrettyPrinter().pprint(rsp)
         return
 
@@ -349,7 +347,7 @@ def main():
           },
         }
 
-        tsinfo = dumpit(ynl, args, 'tsinfo-get', req)
+        tsinfo = do_get(ynl, args, 'tsinfo-get', req)
 
         print(f'Time stamping parameters for {args.device}:')
 
@@ -377,7 +375,7 @@ def main():
         return
 
     print(f'Settings for {args.device}:')
-    linkmodes = dumpit(ynl, args, 'linkmodes-get')
+    linkmodes = do_get(ynl, args, 'linkmodes-get')
     ours = bits_to_dict(linkmodes['ours'])
 
     supported_ports = ('TP',  'AUI', 'BNC', 'MII', 'FIBRE', 'Backplane')
@@ -425,7 +423,7 @@ def main():
             5: 'Directly Attached Copper',
             0xef: 'None',
     }
-    linkinfo = dumpit(ynl, args, 'linkinfo-get')
+    linkinfo = do_get(ynl, args, 'linkinfo-get')
     print(f'Port: {ports.get(linkinfo["port"], "Other")}')
 
     print_field(linkinfo, ('phyaddr', 'PHYAD'))
@@ -447,11 +445,11 @@ def main():
         mdix = mdix_ctrl.get(linkinfo['tp-mdix'], 'Unknown (auto)')
     print(f'MDI-X: {mdix}')
 
-    debug = dumpit(ynl, args, 'debug-get')
+    debug = do_get(ynl, args, 'debug-get')
     msgmask = bits_to_dict(debug.get("msgmask", [])).keys()
     print(f'Current message level: {" ".join(msgmask)}')
 
-    linkstate = dumpit(ynl, args, 'linkstate-get')
+    linkstate = do_get(ynl, args, 'linkstate-get')
     detected_states = {
             0: 'no',
             1: 'yes',

-- 
Git-155)


