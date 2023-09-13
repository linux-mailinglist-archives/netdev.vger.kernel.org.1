Return-Path: <netdev+bounces-33500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E2979E3B3
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4FE280198
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22DE1DDD6;
	Wed, 13 Sep 2023 09:29:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A71DDCF
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:29:13 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E6DDD
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:29:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fc9a4ebe9so2689358b3a.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694597352; x=1695202152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4927du+lhx/qKwL17Woc8hDlj8ZOriGsW+wob/QxK4=;
        b=UG3Ic04xSAVkrlmdXWqiA68siFP+wXQo4LaE2M5aEU5HVIf17m0uzefyIm7f6mmH7c
         Lg5drIxhwasDSExqS+APzyTNbfNpdIpsKffYirWEGXNAqfmuuhB65F/JkfWNvtekFuJn
         Yk2YXa6MxuYYiXO/ZB+bzVThgzdND9T1TyDACtOhFrZSlDusG25Rddrg512nFtDKmoK7
         SqUpUYGo9OYE69h7bJq4Sbf8klz07hRbXLY8D+FxhMWVcP6Q6JLWmv4Eq3OOT/Ywtx9P
         Tn4fIBtM0nNEn6b48S5Q1nZ7PF+HQ43MR5cdIYpUJrbwryRNPY6I5cHeD3rXQVz5YGEO
         YTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597352; x=1695202152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4927du+lhx/qKwL17Woc8hDlj8ZOriGsW+wob/QxK4=;
        b=Q0T6UXe77ots8G2TibJcoxsxZ91nAijZ3At+swEJrcab2ybo5PT5loPZNinRkYXk5b
         s2gCFvF3smrAee2yQE+JHQaz455YUFpQMR7W0L3g/qQFnY/QMlVXivezMf9ns4QKzfCx
         MCUGlnjyo0tAe5uAAbW8Ov6TYNXP3DI/g6c/C6ee+r0+H8f9yee221Pa4MzTBCVNRCl5
         q4/fcUmsWRwJalBNakcfgMuAbBJyxXbB0qTMj4Q2LToiITlPAOoyDsOdlRrOgVEJD/+a
         1PxT1gGVaFvPVJYTY4FKLw5wRXiXRHAEVCHxajlG9vpYbIPwWnnubSBUaw+EewChXquR
         eOaw==
X-Gm-Message-State: AOJu0YyYOwCCYYmkNliE1Hly0QMkrPU1ghjYz0/Pl8IF5MSdE7LKAhn1
	LOWHlIC69UBdnphkdy2kvNc+nIg53R2/XeYP
X-Google-Smtp-Source: AGHT+IFMjLDCgqQxIU2sByQWhODdBY9JlnH8rSRA6kh9Ip3aGGYrwiuzgUdaTKQWWPj8qNkeKV26KA==
X-Received: by 2002:a05:6a21:60f:b0:14d:f41c:435a with SMTP id ll15-20020a056a21060f00b0014df41c435amr1513284pzb.39.1694597352023;
        Wed, 13 Sep 2023 02:29:12 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001bbb1eec92esm9951481plg.281.2023.09.13.02.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:29:11 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC Draft PATCH iproute2-next] tools: add a tool to generate bridge man doc
Date: Wed, 13 Sep 2023 17:28:54 +0800
Message-ID: <20230913092854.1027336-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913092854.1027336-1-liuhangbin@gmail.com>
References: <20230913092854.1027336-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tool will generate the ip link bridge parameters and find related
attr description in if_link.h. And convert to the new man doc.

To use it. You need to run the script first before your patch. With this
we can update the man page to latest version. e.g.

./generate_bridge_man.py -i iproute2_dir -n net-next_dir

The script will generate a ip-link.8.out page. You can check if it's OK
to move to ip-link.8.in.

After adding new parameter. You need to re-run the script to generate the man
doc from net-next header file.

The script check the existing parameter. So if the attr in net-next has not
added to iproute2, it will not generate the man doc.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 man/man8/ip-link.8.in        |   2 +
 tools/generate_bridge_man.py | 188 +++++++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+)
 create mode 100755 tools/generate_bridge_man.py

diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 8f07de9a8a25..cbf6d9a9d9c4 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1611,6 +1611,7 @@ For a link of type
 the following additional arguments are supported:
 
 .BI "ip link add " DEVICE " type bridge "
+.\" bridge man doc starts
 [
 .BI ageing_time " AGEING_TIME "
 ] [
@@ -1887,6 +1888,7 @@ arptables hooks on the bridge.
 
 
 .in -8
+.\" bridge man doc ends
 
 .TP
 MACsec Type Support
diff --git a/tools/generate_bridge_man.py b/tools/generate_bridge_man.py
new file mode 100755
index 000000000000..45947abda382
--- /dev/null
+++ b/tools/generate_bridge_man.py
@@ -0,0 +1,188 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+
+import re, sys, os
+import argparse
+from docutils import core
+
+man_bridge = ""
+
+def handle_args():
+    parser = argparse.ArgumentParser(description="""Convert bridge header
+                                     comments to iproute2 man doc.""")
+    parser.add_argument('-i', '--iproute2-dir', required=True,
+                        help='iproute code path')
+    parser.add_argument('-n', '--net-dir', required=True,
+                        help='net-next code path')
+    args = parser.parse_args()
+    return args
+
+def write_man_doc(input_file, output_file):
+    try:
+        with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
+            remove_flag = False
+            for line in infile:
+                if line.find("bridge man doc starts") != -1:
+                    remove_flag = True
+                    outfile.write(line)
+                    outfile.write(man_bridge + '\n')
+                elif remove_flag and line.find("bridge man doc ends") != -1:
+                    remove_flag = False
+                elif not remove_flag:
+                    outfile.write(line)
+    except Exception as e:
+        sys.exit(e)
+
+def append_man_line(line, end = '\n'):
+    global man_bridge
+    man_bridge = man_bridge + line + end
+
+def rst2man(node):
+    if not hasattr(node, 'astext'):
+        return
+
+    if node.tagname == 'bullet_list':
+        append_man_line('.in +8\n.sp')
+    if node.tagname == 'list_item':
+        append_man_line('')
+    elif node.tagname == 'emphasis':
+        append_man_line('.I ', end = '')
+    elif node.tagname == 'strong':
+        append_man_line('.B ', end = '')
+
+    for child_node in node.children:
+        rst2man(child_node)
+
+    if len(node.children) == 0:
+        text = node.astext().strip()
+        append_man_line(text)
+
+    if node.tagname == 'bullet_list':
+        append_man_line('.in -8')
+
+def convert2man(params):
+    first = True
+    for p in params:
+        if first:
+            first = False
+            append_man_line('[')
+        else:
+            append_man_line(' [')
+        append_man_line('.BI ' + p + ' " ' + params[p]['param'] + ' "')
+        append_man_line(']', end = '')
+
+    append_man_line('\n\n.in +8\n.sp')
+
+    for p in params:
+        if 'alias' in params[p]:
+            # TODO: fix the vlan_protocol output, e.g. {|}
+            append_man_line('\n.BR ' + p + ' " ' + params[p]['alias'] + ' "')
+        else:
+            append_man_line('\n.BI ' + p + ' " ' + params[p]['param'] + ' "')
+        # Add the '- ' at begining of each description
+        append_man_line('- ', end = '')
+        if 'doc' in params[p]:
+            rst_nodes = core.publish_doctree(params[p]['doc'])
+            rst2man(rst_nodes)
+
+def strip_doc_line(line, param):
+    # Remove the first " *   "
+    line = line[5:-1]
+    # replace attr with param, e.g. IFLA_BR_STP_STATE -> STP_STATE
+    line = line.replace(param['attr'], param['param'])
+    return line
+
+def get_attr(line):
+    match = re.search(r'@(\w+):', line)
+    if match:
+        return match.group(1)
+    return None
+
+# Deal some irregular namings
+def param2attr(param):
+    param = param.replace('count', 'cnt')
+    param = param.replace('interval', 'intvl')
+    param = param.replace('group_address', 'group_addr')
+    return param.upper()
+
+def get_bridge_doc(bridge_header, params):
+    find_attr = False
+    p = None
+    try:
+        with open(bridge_header, 'r') as f:
+            line = f.readline()
+            # Find the start of the doc
+            while line.find("DOC: The bridge emum defination") == -1:
+                if not line:
+                    print("Unable to find bridge DOC");
+                    return None
+                line = f.readline()
+            # Till the end of the doc
+            while line.find("*/") == -1:
+                line = f.readline()
+                # Start of a parameter
+                if line.find(' * @') == 0:
+                    find_attr = False
+                    for p in params:
+                        if line.find(param2attr(p) + ':') != -1:
+                            attr = get_attr(line)
+                            if attr is not None:
+                                params[p]['attr'] = attr
+                                find_attr = True
+                            break
+                elif find_attr and p:
+                    if 'doc' in params[p]:
+                        params[p]['doc'] = params[p]['doc'] + '\n' + strip_doc_line(line, params[p])
+                    else:
+                        params[p]['doc'] = strip_doc_line(line, params[p])
+
+    except Exception as e:
+        sys.exit(e)
+
+# replace multi text
+def strip_line(line):
+    return line.replace(' ', '').replace('"', '').replace('\\n', '').strip()
+
+def get_bridge_parameter(bridge_file):
+    params = {}
+    try:
+        with open(bridge_file, 'r') as f:
+            line = f.readline()
+            # Find the start of parameters
+            while line.find("Usage: ... bridge") == -1:
+                line = f.readline()
+            # Till the end of the parameters
+            while line.find("Where:") == -1:
+                line = f.readline()
+                parts = line.strip().split()
+                if len(parts) >= 4:
+                    if parts[1] == '[':
+                        params[parts[2]] = {}
+                        params[parts[2]]['param'] = parts[3]
+            # Till the end of usage function to get the alias
+            while line.find(");") == -1:
+                parts = line.strip().replace('Where:', '').split(':=')
+                alias = strip_line(parts[0])
+                for p in params:
+                    if params[p]['param'] == alias:
+                        params[p]['alias'] = strip_line(parts[1])
+                line = f.readline()
+    except Exception as e:
+        sys.exit(e)
+
+    return params
+
+def main():
+    args = handle_args()
+    bridge_file = args.iproute2_dir.rstrip('/') + "/ip/iplink_bridge.c"
+    ip_link_in = args.iproute2_dir.rstrip('/') + "/man/man8/ip-link.8.in"
+    ip_link_out = args.iproute2_dir.rstrip('/') + "/man/man8/ip-link.8.out"
+    bridge_header = args.net_dir.rstrip('/') + '/include/uapi/linux/if_link.h'
+
+    bridge_params = get_bridge_parameter(bridge_file)
+    get_bridge_doc(bridge_header, bridge_params)
+    convert2man(bridge_params)
+    write_man_doc(ip_link_in, ip_link_out)
+
+if __name__ == '__main__':
+    main()
-- 
2.41.0


