Return-Path: <netdev+bounces-44687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A47D939B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6265328249A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CFC168A4;
	Fri, 27 Oct 2023 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YT7OXJfh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AAB15ACE
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 09:25:32 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B2811F
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:25:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso27899741fa.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698398727; x=1699003527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUUpngVlaOAByI/nQjchjHe6TO5WwO/lE+DrNgWMUAg=;
        b=YT7OXJfh+yCgmFFgkOjBufzBnarSdDkwOt94I9mUFtpA1XpxvYA+wxkMR4dpErRI4v
         w7/SAF5oRYx0ZyLxeltYPRfL62QIN3gmeW3pqNfjB0Ipz+jXz+DaQQBpF3eQXDH3tJpv
         wKgJaTtHiPe+3kPdQhCrz9LGZDyMGZ1Z8y/dP0mtfMK8qz/LLNLCpA1x0mlFMJcuqv97
         sei/Vb70/5MuLJPsT+VeGWt9Tfhxa+bijCeDymv/NlzdqVuBYo40UlLkVlyJRgKJcltZ
         1GbXHdEYy2M3tx+ymzTXRdnLrzF1T0UVr74LTl+R5lAi/n7o5J8Mc8S99hrSZl1exT8s
         6HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698398727; x=1699003527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUUpngVlaOAByI/nQjchjHe6TO5WwO/lE+DrNgWMUAg=;
        b=Uo2l7F94/aShoZoW676CcXRsGp8lH9VnT18FbeIuEkiWZbSch5tH9+NaRa1CwFf4Vo
         KPCY1Lyn1LZIfB6R+gSQS2dJqZoLFmMSKGp4HY2IVJfWLfxxDX7MzUuamRrGwdNZ8Djw
         cRMgMg39J+eMR/4n2BEhiebKPDuRGqltq7KZIVhAqJmP+pTsyoCBI7khAcSDoW4ZNbbg
         owARnW7WATao/2AZqOPs5W2N7KLg+H4NAiY8+zdcy1XKHBLxCleMG+FUUA4XmTmYzbcR
         dBeSbzrPTk4POJNy3X+7yRYnaK2+UkW/zcLrsKj1SAMNke8VN/BMxwTi6A0avx3uLZdm
         UTdw==
X-Gm-Message-State: AOJu0YzbZ7fyND183UZUdz3Wf/TpmuI4v5pZZspxzIehLUAmFaBf3COT
	4d15DvtQgh6KEF91tZGrTxsG82/G8t8pma6bWJQTKA==
X-Google-Smtp-Source: AGHT+IEplmODgsdqroRNmqlgSeyatWDnGjPer87wcKjw9Z9Ypz9uV8rA96gv56dgUtTr0W+9eSO0vw==
X-Received: by 2002:a05:651c:10b:b0:2c5:24a8:c22d with SMTP id a11-20020a05651c010b00b002c524a8c22dmr1605925ljb.3.1698398727222;
        Fri, 27 Oct 2023 02:25:27 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c2d8300b0040641ce36a8sm2308050wmg.1.2023.10.27.02.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:25:26 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v4] tools: ynl: introduce option to process unknown attributes or types
Date: Fri, 27 Oct 2023 11:25:25 +0200
Message-ID: <20231027092525.956172-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In case the kernel sends message back containing attribute not defined
in family spec, following exception is raised to the user:

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "trap-name": "source_mac_is_multicast"}'
Traceback (most recent call last):
  File "/home/jiri/work/linux/tools/net/ynl/lib/ynl.py", line 521, in _decode
    attr_spec = attr_space.attrs_by_val[attr.type]
                ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
KeyError: 132

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/jiri/work/linux/./tools/net/ynl/cli.py", line 61, in <module>
    main()
  File "/home/jiri/work/linux/./tools/net/ynl/cli.py", line 49, in main
    reply = ynl.do(args.do, attrs, args.flags)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiri/work/linux/tools/net/ynl/lib/ynl.py", line 731, in do
    return self._op(method, vals, flags)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiri/work/linux/tools/net/ynl/lib/ynl.py", line 719, in _op
    rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiri/work/linux/tools/net/ynl/lib/ynl.py", line 525, in _decode
    raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
Exception: Space 'devlink' has no attribute with value '132'

Introduce a command line option "process-unknown" and pass it down to
YnlFamily class constructor to allow user to process unknown
attributes and types and print them as binaries.

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "trap-name": "source_mac_is_multicast"}' --process-unknown
{'UnknownAttr(129)': {'UnknownAttr(0)': b'\x00\x00\x00\x00\x00\x00\x00\x00',
                      'UnknownAttr(1)': b'\x00\x00\x00\x00\x00\x00\x00\x00',
                      'UnknownAttr(2)': b'\x0e\x00\x00\x00\x00\x00\x00\x00'},
 'UnknownAttr(132)': b'\x00',
 'UnknownAttr(133)': b'',
 'UnknownAttr(134)': {'UnknownAttr(0)': b''},
 'bus-name': 'netdevsim',
 'dev-name': 'netdevsim1',
 'trap-action': 'drop',
 'trap-group-name': 'l2_drops',
 'trap-name': 'source_mac_is_multicast'}

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- changed unknown attr key to f"UnknownAttr({attr.type})"
v2->v3:
- rebased on top of previous patchset and recent net-next
- removed fake attr spec class
- introduced "attr.is_nest" and using it instead of direct access
  to "attr._type"
- pushed out rsp value addition into separate helper and sanitize
  the unknown attr is possibly multi-value there
- pushed out unknown attr decode into separate helper
v1->v2:
- changed to process unknown attributes and type instead of ignoring them
---
 tools/net/ynl/cli.py     |  3 ++-
 tools/net/ynl/lib/ynl.py | 48 +++++++++++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 564ecf07cd2c..2ad9ec0f5545 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -27,6 +27,7 @@ def main():
                         const=Netlink.NLM_F_CREATE)
     parser.add_argument('--append', dest='flags', action='append_const',
                         const=Netlink.NLM_F_APPEND)
+    parser.add_argument('--process-unknown', action=argparse.BooleanOptionalAction)
     args = parser.parse_args()
 
     if args.no_schema:
@@ -36,7 +37,7 @@ def main():
     if args.json_text:
         attrs = json.loads(args.json_text)
 
-    ynl = YnlFamily(args.spec, args.schema)
+    ynl = YnlFamily(args.spec, args.schema, args.process_unknown)
 
     if args.ntf:
         ynl.ntf_subscribe(args.ntf)
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index b1da4aea9336..92995bca14e1 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -100,6 +100,7 @@ class NlAttr:
     def __init__(self, raw, offset):
         self._len, self._type = struct.unpack("HH", raw[offset:offset + 4])
         self.type = self._type & ~Netlink.NLA_TYPE_MASK
+        self.is_nest = self._type & Netlink.NLA_F_NESTED
         self.payload_len = self._len
         self.full_len = (self.payload_len + 3) & ~3
         self.raw = raw[offset + 4:offset + self.payload_len]
@@ -411,10 +412,11 @@ class GenlProtocol(NetlinkProtocol):
 
 
 class YnlFamily(SpecFamily):
-    def __init__(self, def_path, schema=None):
+    def __init__(self, def_path, schema=None, process_unknown=False):
         super().__init__(def_path, schema)
 
         self.include_raw = False
+        self.process_unknown = process_unknown
 
         try:
             if self.proto == "netlink-raw":
@@ -526,14 +528,41 @@ class YnlFamily(SpecFamily):
             decoded.append({ item.type: subattrs })
         return decoded
 
+    def _decode_unknown(self, attr):
+        if attr.is_nest:
+            return self._decode(NlAttrs(attr.raw), None)
+        else:
+            return attr.as_bin()
+
+    def _rsp_add(self, rsp, name, is_multi, decoded):
+        if is_multi == None:
+            if name in rsp and type(rsp[name]) is not list:
+                rsp[name] = [rsp[name]]
+                is_multi = True
+            else:
+                is_multi = False
+
+        if not is_multi:
+            rsp[name] = decoded
+        elif name in rsp:
+            rsp[name].append(decoded)
+        else:
+            rsp[name] = [decoded]
+
     def _decode(self, attrs, space):
-        attr_space = self.attr_sets[space]
+        if space:
+            attr_space = self.attr_sets[space]
         rsp = dict()
         for attr in attrs:
             try:
                 attr_spec = attr_space.attrs_by_val[attr.type]
-            except KeyError:
-                raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
+            except (KeyError, UnboundLocalError):
+                if not self.process_unknown:
+                    raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
+                attr_name = f"UnknownAttr({attr.type})"
+                self._rsp_add(rsp, attr_name, None, self._decode_unknown(attr))
+                continue
+
             if attr_spec["type"] == 'nest':
                 subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'])
                 decoded = subdict
@@ -558,14 +587,11 @@ class YnlFamily(SpecFamily):
                     selector = self._decode_enum(selector, attr_spec)
                 decoded = {"value": value, "selector": selector}
             else:
-                raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
+                if not self.process_unknown:
+                    raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
+                decoded = self._decode_unknown(attr)
 
-            if not attr_spec.is_multi:
-                rsp[attr_spec['name']] = decoded
-            elif attr_spec.name in rsp:
-                rsp[attr_spec.name].append(decoded)
-            else:
-                rsp[attr_spec.name] = [decoded]
+            self._rsp_add(rsp, attr_spec["name"], attr_spec.is_multi, decoded)
 
         return rsp
 
-- 
2.41.0


