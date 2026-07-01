Return-Path: <netdev+bounces-303440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GlYFEf14RGqVvQoAu9opvQ
	(envelope-from <netdev+bounces-303440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:18:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D16E93AD
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:18:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PrGcwGtV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303440-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303440-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B09BE3059A4A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 02:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB17263B;
	Wed,  1 Jul 2026 02:17:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767817C211
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 02:17:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872277; cv=none; b=XZYmTP98D7RJ++oZUkxPrE1PNUMOWRbAABfxCT/cDNKit7yEZ4LqCse09WQhr+K6F85GEwrYF+BsxZBk4Ovo1m7RXQ3Zpm2KqD+axoyz21KLGa0/5x2zZT1Hf3gW7smKJLbdiLLDiuJn0eLgyqvjUKKAyTOBMVNURuKhDYMlft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872277; c=relaxed/simple;
	bh=nTTEK81JFZnxW6ofe9hO+5MnNchn7ZDgf68GJ6UOM+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1sncTIKYkoGAm3QaMeZ4pPmS+bQzlhXjrol3AJx0RRxbUKlkjA4szX9fUPRD1HwesIm0vwaPh41FAui4l5sywAWvdisJE3D1Dj66szrFwbpeUN6zmrr43e13opTsMKL6s9awuDEqq7tVbDdJ4jdBkUf7Mn7J9qF9ib8rlxbYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrGcwGtV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE53F1F00AC4;
	Wed,  1 Jul 2026 02:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872275;
	bh=rMQw0ja9d+ogVwNldjq1wlFp0nXq7JJjqCzzTdRrEwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PrGcwGtVFihVKpYLoMnq6d14Yj7fj44c/VxI5BmGN0hjBcvxPxlq2mzXTUsuDaXVE
	 jdoq2Xe3j6B5T86ictEiqblgKfn81pIwKU72ZjssRL6/gbumJ5/V2V54LqxogdGgWv
	 LuOM9A2UI9tyBmrxVZNQpzg/pF/Ao1DkkpPldHDeU6HXXWJzBLc3LUHgvnOgwd2FzW
	 8Vm2VrYvfsE9cOQ/k1nwzgxlN9ztCmBCtjKM4LrwAgxfM+kpC8t01MxVvRy6B8BcyH
	 UpkVol4YDQOQ3aMOpNXF9bav1z6ZIlnInYcA+tXB3RmXick/mIxrqUEZY7uVeGCeMb
	 d1kC0gn9nbaIw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	gal@nvidia.com,
	jstancek@redhat.com,
	ast@fiberby.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/2] tools: ynl: pyynl: pull the --family resolution logic into the lib
Date: Tue, 30 Jun 2026 19:17:51 -0700
Message-ID: <20260701021751.3234681-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701021751.3234681-1-kuba@kernel.org>
References: <20260701021751.3234681-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303440-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:donald.hunter@gmail.com,m:sdf@fomichev.me,m:gal@nvidia.com,m:jstancek@redhat.com,m:ast@fiberby.net,m:kuba@kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me,nvidia.com,fiberby.net];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C7D16E93AD

When packaging YNL as a system level utility we added a --family
argument which auto-resolves the full spec path from a well known
path in /usr/share. Spelling out full YAML spec files is at this
point only done in-tree, for example in the selftests which need
the very latest YAML. But the selftests have their own wrapping
classes for each family so test authors aren't really bothered
by having to spell the paths out.

Afford the same ease of use to the Python library users.
Move the path resolution from the CLI code to the library.
This simplifies the pyynl use by a lot:

  from pyynl import YnlFamily

  ynl = YnlFamily(family="netdev")

Unless I'm missing a trick, resolving the /usr/share path
is hard enough for most users to lean towards shelling out
to ynl CLI with --output-json, which is sad.

The ethtool script can now use family= instead of
resolving the path (the helpers are removed from cli.py
so this isn't just a cleanup).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix the ethtool script (Donald)
 - fix --family=X --validate (Clashiko)
v1: https://lore.kernel.org/20260630001432.2204298-3-kuba@kernel.org
---
 tools/net/ynl/pyynl/cli.py          | 56 +++++++----------------------
 tools/net/ynl/pyynl/lib/__init__.py |  3 +-
 tools/net/ynl/pyynl/lib/nlspec.py   | 22 ++++++++++--
 tools/net/ynl/pyynl/lib/specdir.py  | 51 ++++++++++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py      | 19 ++++++++--
 tools/net/ynl/tests/ethtool.py      |  7 +---
 6 files changed, 102 insertions(+), 56 deletions(-)
 create mode 100644 tools/net/ynl/pyynl/lib/specdir.py

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 8275a806cf73..b6a6ce12b4a7 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -17,9 +17,7 @@ import textwrap
 # pylint: disable=no-name-in-module,wrong-import-position
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily, Netlink, NlError, SpecFamily, SpecException, YnlException
-
-SYS_SCHEMA_DIR='/usr/share/ynl'
-RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
+from lib import list_families
 
 # pylint: disable=too-few-public-methods,too-many-locals
 class Colors:
@@ -48,30 +46,6 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
     """ Get terminal width in columns (80 if stdout is not a terminal) """
     return shutil.get_terminal_size().columns
 
-def schema_dir():
-    """
-    Return the effective schema directory, preferring in-tree before
-    system schema directory.
-    """
-    script_dir = os.path.dirname(os.path.abspath(__file__))
-    schema_dir_ = os.path.abspath(f"{script_dir}/{RELATIVE_SCHEMA_DIR}")
-    if not os.path.isdir(schema_dir_):
-        schema_dir_ = SYS_SCHEMA_DIR
-    if not os.path.isdir(schema_dir_):
-        raise YnlException(f"Schema directory {schema_dir_} does not exist")
-    return schema_dir_
-
-def spec_dir():
-    """
-    Return the effective spec directory, relative to the effective
-    schema directory.
-    """
-    spec_dir_ = schema_dir() + '/specs'
-    if not os.path.isdir(spec_dir_):
-        raise YnlException(f"Spec directory {spec_dir_} does not exist")
-    return spec_dir_
-
-
 class YnlEncoder(json.JSONEncoder):
     """A custom encoder for emitting JSON with ynl-specific instance types"""
     def default(self, o):
@@ -272,9 +246,8 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
             pprint.pprint(msg, width=term_width(), compact=True)
 
     if args.list_families:
-        for filename in sorted(os.listdir(spec_dir())):
-            if filename.endswith('.yaml'):
-                print(filename.removesuffix('.yaml'))
+        for family in list_families():
+            print(family)
         return
 
     if args.no_schema:
@@ -284,28 +257,23 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
     if args.json_text:
         attrs = json.loads(args.json_text)
 
-    if args.family:
-        spec = f"{spec_dir()}/{args.family}.yaml"
-    else:
-        spec = args.spec
-    if not os.path.isfile(spec):
-        raise YnlException(f"Spec file {spec} does not exist")
+    if args.spec and not os.path.isfile(args.spec):
+        raise YnlException(f"Spec file {args.spec} does not exist")
 
+    # Spec/YnlFamily will raise if both or neither spec and family are given
     if args.validate:
+        # Force validation even for installed specs (schema=True), unless the
+        # user explicitly picked a schema or opted out with --no-schema.
+        schema = True if args.schema is None else args.schema
         try:
-            SpecFamily(spec, args.schema)
+            SpecFamily(args.spec, schema_path=schema, family=args.family)
         except SpecException as error:
             print(error)
             sys.exit(1)
         return
 
-    if args.family: # set behaviour when using installed specs
-        if args.schema is None and spec.startswith(SYS_SCHEMA_DIR):
-            args.schema = '' # disable schema validation when installed
-        if args.process_unknown is None:
-            args.process_unknown = True
-
-    ynl = YnlFamily(spec, args.schema, args.process_unknown,
+    ynl = YnlFamily(args.spec, schema=args.schema, family=args.family,
+                    process_unknown=args.process_unknown,
                     recv_size=args.dbg_small_recv)
     if args.dbg_small_recv:
         ynl.set_recv_dbg(True)
diff --git a/tools/net/ynl/pyynl/lib/__init__.py b/tools/net/ynl/pyynl/lib/__init__.py
index be741985ae4e..aa4263c8cba9 100644
--- a/tools/net/ynl/pyynl/lib/__init__.py
+++ b/tools/net/ynl/pyynl/lib/__init__.py
@@ -5,12 +5,13 @@
 from .nlspec import SpecAttr, SpecAttrSet, SpecEnumEntry, SpecEnumSet, \
     SpecFamily, SpecOperation, SpecSubMessage, SpecSubMessageFormat, \
     SpecException
+from .specdir import list_families
 from .ynl import YnlFamily, Netlink, NlError, NlPolicy, YnlException
 
 from .doc_generator import YnlDocGenerator
 
 __all__ = ["SpecAttr", "SpecAttrSet", "SpecEnumEntry", "SpecEnumSet",
            "SpecFamily", "SpecOperation", "SpecSubMessage", "SpecSubMessageFormat",
-           "SpecException",
+           "SpecException", "list_families",
            "YnlFamily", "Netlink", "NlError", "NlPolicy", "YnlException",
            "YnlDocGenerator"]
diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index 0469a0e270d0..b4ec59814ab1 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -12,6 +12,8 @@ import importlib
 import os
 import yaml as pyyaml
 
+from .specdir import find_spec, SYS_SCHEMA_DIR
+
 
 class SpecException(Exception):
     """Netlink spec exception.
@@ -444,7 +446,23 @@ import yaml as pyyaml
     except AttributeError:
         _yaml_loader = pyyaml.SafeLoader
 
-    def __init__(self, spec_path, schema_path=None, exclude_ops=None):
+    def __init__(self, spec_path=None, schema_path=None, exclude_ops=None,
+                 family=None):
+        # schema_path selects how the spec is validated:
+        #   None  -- no preference: validate against the default schema,
+        #            but trust (skip) installed specs selected by family=
+        #   True  -- always validate against the default schema
+        #   path  -- validate against this schema
+        #   ''    -- do not validate
+        if (spec_path is None) == (family is None):
+            raise ValueError("Specify exactly one of spec path or family name")
+        if family is not None:
+            spec_path = find_spec(family)
+            # Installed specs are assumed correct, so skip schema validation
+            # to save cycles unless the caller asked to validate.
+            if schema_path is None and spec_path.startswith(SYS_SCHEMA_DIR):
+                schema_path = ''
+
         with open(spec_path, "r", encoding='utf-8') as stream:
             prefix = '# SPDX-License-Identifier: '
             first = stream.readline().strip()
@@ -465,7 +483,7 @@ import yaml as pyyaml
         self.proto = self.yaml.get('protocol', 'genetlink')
         self.msg_id_model = self.yaml['operations'].get('enum-model', 'unified')
 
-        if schema_path is None:
+        if schema_path is None or schema_path is True:
             schema_path = os.path.dirname(os.path.dirname(spec_path)) + f'/{self.proto}.yaml'
         if schema_path:
             with open(schema_path, "r", encoding='utf-8') as stream:
diff --git a/tools/net/ynl/pyynl/lib/specdir.py b/tools/net/ynl/pyynl/lib/specdir.py
new file mode 100644
index 000000000000..fcea9b9fb7b0
--- /dev/null
+++ b/tools/net/ynl/pyynl/lib/specdir.py
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+"""
+Locating YNL spec and schema files on disk.
+
+Resolves the directory holding the YAML specs (preferring an in-tree copy
+over the installed system path) and maps family names to spec files.
+"""
+
+import os
+
+SYS_SCHEMA_DIR='/usr/share/ynl'
+RELATIVE_SCHEMA_DIR='../../../../../Documentation/netlink'
+
+
+def schema_dir():
+    """
+    Return the effective schema directory, preferring in-tree before
+    system schema directory.
+    """
+    script_dir = os.path.dirname(os.path.abspath(__file__))
+    schema_dir_ = os.path.abspath(f"{script_dir}/{RELATIVE_SCHEMA_DIR}")
+    if not os.path.isdir(schema_dir_):
+        schema_dir_ = SYS_SCHEMA_DIR
+    if not os.path.isdir(schema_dir_):
+        raise FileNotFoundError(f"Schema directory {schema_dir_} does not exist")
+    return schema_dir_
+
+def spec_dir():
+    """
+    Return the effective spec directory, relative to the effective
+    schema directory.
+    """
+    spec_dir_ = schema_dir() + '/specs'
+    if not os.path.isdir(spec_dir_):
+        raise FileNotFoundError(f"Spec directory {spec_dir_} does not exist")
+    return spec_dir_
+
+
+def find_spec(family):
+    """ Return the path to the YAML spec file for a family by name. """
+    spec = f"{spec_dir()}/{family}.yaml"
+    if not os.path.isfile(spec):
+        raise FileNotFoundError(f"Spec for family '{family}' not found at {spec}")
+    return spec
+
+
+def list_families():
+    """ Return the sorted names of all families with an installed spec. """
+    return sorted(f.removesuffix('.yaml')
+                  for f in os.listdir(spec_dir()) if f.endswith('.yaml'))
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 092d132edec1..8682bf588e1f 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -661,6 +661,14 @@ from .nlspec import SpecFamily
     """
     YNL family -- a Netlink interface built from a YAML spec.
 
+    The spec can be selected either by file path (def_path=) or, when it
+    ships in a well-known location, by family name (family="xyz"); exactly
+    one of the two must be given. For example:
+
+      from pyynl import YnlFamily
+
+      ynl = YnlFamily(family="netdev")
+
     Primary use of the class is to execute Netlink commands:
 
       ynl.<op_name>(attrs, ...)
@@ -691,11 +699,16 @@ from .nlspec import SpecFamily
 
       ynl.get_policy(op_name, mode)      -- query kernel policy for an op
     """
-    def __init__(self, def_path, schema=None, process_unknown=False,
-                 recv_size=0):
-        super().__init__(def_path, schema)
+    def __init__(self, def_path=None, schema=None, process_unknown=None,
+                 recv_size=0, family=None):
+        super().__init__(def_path, schema, family=family)
 
         self.include_raw = False
+        # Specs from /usr (selected by family=) have a higher chance of being
+        # stale, default to ignoring unknown attrs. In-tree users, and users
+        # who bundle the spec need to make a conscious decision.
+        if process_unknown is None:
+            process_unknown = family is not None
         self.process_unknown = process_unknown
 
         try:
diff --git a/tools/net/ynl/tests/ethtool.py b/tools/net/ynl/tests/ethtool.py
index db3b62c652e7..0ee0c8e87686 100755
--- a/tools/net/ynl/tests/ethtool.py
+++ b/tools/net/ynl/tests/ethtool.py
@@ -11,12 +11,10 @@ import pathlib
 import pprint
 import sys
 import re
-import os
 
 # pylint: disable=no-name-in-module,wrong-import-position
 sys.path.append(pathlib.Path(__file__).resolve().parent.parent.joinpath('pyynl').as_posix())
 # pylint: disable=import-error
-from cli import schema_dir, spec_dir
 from lib import YnlFamily
 
 
@@ -173,10 +171,7 @@ from lib import YnlFamily
 
     args = parser.parse_args()
 
-    spec = os.path.join(spec_dir(), 'ethtool.yaml')
-    schema = os.path.join(schema_dir(), 'genetlink-legacy.yaml')
-
-    ynl = YnlFamily(spec, schema, recv_size=args.dbg_small_recv)
+    ynl = YnlFamily(family='ethtool', recv_size=args.dbg_small_recv)
     if args.dbg_small_recv:
         ynl.set_recv_dbg(True)
 
-- 
2.54.0


