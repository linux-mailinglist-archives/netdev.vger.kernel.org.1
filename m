Return-Path: <netdev+bounces-266742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIA3Ghe2sWl2EwAAu9opvQ
	(envelope-from <netdev+bounces-266742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:36:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD39268AF5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60A1D301F687
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1533F3E8691;
	Wed, 11 Mar 2026 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuuiGpmx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0E2F1FED;
	Wed, 11 Mar 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254162; cv=none; b=G3wL/wMPZ5isAt+g0It+aU/mlXysvWWMzQ9W8hVeRfKiUGkOtis9puOZ7ZMQ3hDtkHDnSpmZy4aalRqb2pD4xBunbdKSg1a+GWS8K5xeHNpqKKC4q0FZDnSOmbJMpQUC4U6LV3N1UdwezjH/iMV7cLeggXlYutw9Ve/c2AhBJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254162; c=relaxed/simple;
	bh=Lab18BB3orM/nud1CgsXXO+rESiy+sNlGvfoXi3Mvvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gqqr8isjdXOMQ3b7PKmsWz4mW7Epa1G3c4PmUDAiNk6zbVAfuR5UURvFnNfXMEEcemauTQJAMWbcjwy2K25ChaY9EPKzrWrVL4f0nYEnE7YUkwYCzshRwrsr4uzXDrnWhUJZf6NIh0DzvRGeMykiGZxvdOLO+43RghjThWxO9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuuiGpmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEC2C2BCB0;
	Wed, 11 Mar 2026 18:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773254161;
	bh=Lab18BB3orM/nud1CgsXXO+rESiy+sNlGvfoXi3Mvvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uuuiGpmxS7BPZc6lu67IfUDvZv1exAeM6z2bbeiKZtt7SKQPlS/qzRA2qlXphwqY7
	 48qmYJD9W49N9PRr0D/FPUzMYGp41eZPwIFx11JlwhGZFWmKtGPqcTQ5h5LISrYla0
	 ewngPBJy2HoqIlLRVw8HOCg0WLb9I7QagKLYdVOMw4worh9vfOhDa4ZecoUAzgwUjo
	 8Pseio+pjqizc40Sj89RB9qMd3k6toHQef2V57fW0Git3vYdYEbGU3QJauov32yXzp
	 kZRgmEiUshkSN5BsN9DoLgCBX69WojWDosYKL4DnE2rbTaSvEF0QM5mMlRg9X1NPvn
	 Ei0+2+Bwp+4oA==
Date: Wed, 11 Mar 2026 11:35:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] tools: ynl: policy query support
Message-ID: <20260311113550.6b493008@kernel.org>
In-Reply-To: <m2jyviob64.fsf@gmail.com>
References: <20260310005337.3594225-1-kuba@kernel.org>
	<177319682153.3014711.5472638473199917370.git-patchwork-notify@kernel.org>
	<m2jyviob64.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266742-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,args.do:url]
X-Rspamd-Queue-Id: 0FD39268AF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 11:30:59 +0000 Donald Hunter wrote:
> > On Mon,  9 Mar 2026 17:53:32 -0700 you wrote:  
> >> Improve the Netlink policy support in YNL. This series grew out of
> >> improvements to policy checking, when writing selftests I realized
> >> that instead of doing all the policy parsing in the test we're
> >> better off making it part of YNL itself.
> >> 
> >> Patch 1 adds pad handling, apparently we never hit pad with commonly
> >> used families. nlctrl policy dumps use pad more frequently.
> >> Patch 2 is a trivial refactor.
> >> Patch 3 pays off some technical debt in terms of documentation.
> >> The YnlFamily class is growing in size and it's quite hard to
> >> find its members. So document it a little bit.
> >> Patch 4 is the main dish, the implementation of get_policy(op)
> >> in YnlFamily.
> >> Patch 5 plugs the new functionality into the CLI.  
> 
> I was mid review

Sorry about that! :( I didn't see any reply to the one liner for a few
days I thought you may be AFK :)

> looking at a couple of issues:
> 
> - It would be good to fail more gracefully for netlink-raw families

This one I saw, but I figured the message that gets printed is...
reasonable. For low level functionality like policies we should 
assume user is relatively advanced? The policies are spotty
even in genetlink, a lot of families don't link them up properly :(
So explaining all of this is a bit of a rabbit hole.

> - I get "RecursionError: maximum recursion depth exceeded" for nl80211

:o Missed this one completely! My feeling is that we should lean into
the NlPolicy class more, and avoid rendering the full structure upfront.
WDYT about the following?

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index fc9e84754e4b..ff0cfbdc82e4 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -16,7 +16,8 @@ import textwrap
 
 # pylint: disable=no-name-in-module,wrong-import-position
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
-from lib import YnlFamily, Netlink, NlError, SpecFamily, SpecException, YnlException
+from lib import SpecFamily, SpecException
+from lib import YnlFamily, Netlink, NlError, NlPolicy, YnlException
 
 SYS_SCHEMA_DIR='/usr/share/ynl'
 RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
@@ -79,6 +80,8 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
             return bytes.hex(o)
         if isinstance(o, set):
             return sorted(o)
+        if isinstance(o, NlPolicy):
+            return o.to_dict()
         return json.JSONEncoder.default(self, o)
 
 
@@ -313,11 +316,11 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
     if args.policy:
         if args.do:
             pol = ynl.get_policy(args.do, 'do')
-            output(pol.attrs if pol else None)
+            output(pol if pol else None)
             args.do = None
         if args.dump:
             pol = ynl.get_policy(args.dump, 'dump')
-            output(pol.attrs if pol else None)
+            output(pol if pol else None)
             args.dump = None
 
     if args.ntf:
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 0eedeee465d8..4411f1902ae4 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -143,32 +143,113 @@ from .nlspec import SpecFamily
     pass
 
 
-# pylint: disable=too-few-public-methods
 class NlPolicy:
     """Kernel policy for one mode (do or dump) of one operation.
 
-    Returned by YnlFamily.get_policy(). Contains a dict of attributes
-    the kernel accepts, with their validation constraints.
+    Returned by YnlFamily.get_policy(). Attributes of the policy
+    are accessible as attributes of the object. Nested policies
+    can be accessed indexing the object like a dictionary::
 
-    Attributes:
-        attrs: dict mapping attribute names to policy dicts, e.g.
-        page-pool-stats-get do policy::
+        pol = ynl.get_policy('page-pool-stats-get', 'do')
+        pol['info'].type            # 'nested'
+        pol['info']['id'].type      # 'uint'
+        pol['info']['id'].min_value # 1
 
-            {
-                'info': {'type': 'nested', 'policy': {
-                    'id':      {'type': 'uint', 'min-value': 1,
-                                'max-value': 4294967295},
-                    'ifindex': {'type': 'u32', 'min-value': 1,
-                                'max-value': 2147483647},
-                }},
-            }
+    Each policy entry always has a 'type' attribute (e.g. u32, string,
+    nested). Optional attributes depending on the 'type': min-value,
+    max-value, min-length, max-length, mask.
 
-        Each policy dict always contains 'type' (e.g. u32, string,
-        nested). Optional keys: min-value, max-value, min-length,
-        max-length, mask, policy.
+    Policies can form infinite nesting loops. These loops are trimmed
+    when policy is converted to a dict with pol.to_dict().
     """
-    def __init__(self, attrs):
-        self.attrs = attrs
+    def __init__(self, ynl, policy_idx, policy_table, attr_set, props=None):
+        self._policy_idx = policy_idx
+        self._policy_table = policy_table
+        self._ynl = ynl
+        self._props = props or {}
+        self._entries = {}
+        if policy_idx is not None and policy_idx in policy_table:
+            for attr_id, decoded in policy_table[policy_idx].items():
+                if attr_set and attr_id in attr_set.attrs_by_val:
+                    spec = attr_set.attrs_by_val[attr_id]
+                    name = spec['name']
+                else:
+                    spec = None
+                    name = f'attr-{attr_id}'
+                self._entries[name] = (spec, decoded)
+
+    def __getitem__(self, name):
+        """Descend into a nested policy by attribute name."""
+        spec, decoded = self._entries[name]
+        props = dict(decoded)
+        child_idx = None
+        child_set = None
+        if 'policy-idx' in props:
+            child_idx = props.pop('policy-idx')
+            if spec and 'nested-attributes' in spec.yaml:
+                child_set = self._ynl.attr_sets[spec.yaml['nested-attributes']]
+        return NlPolicy(self._ynl, child_idx, self._policy_table,
+                        child_set, props)
+
+    def __getattr__(self, name):
+        """Access this policy entry's own properties (type, min-value, etc.).
+
+        Underscores in the name are converted to dashes, so that
+        pol.min_value looks up "min-value".
+        """
+        key = name.replace('_', '-')
+        try:
+            # Hack for level-0 which we still want to have .type but we don't
+            # want type to pointlessly show up in the dict / JSON form.
+            if not self._props and name == "type":
+                return "nested"
+            return self._props[key]
+        except KeyError:
+            raise AttributeError(name)
+
+    def get(self, name, default=None):
+        """Look up a child policy entry by attribute name, with a default."""
+        try:
+            return self[name]
+        except KeyError:
+            return default
+
+    def __contains__(self, name):
+        return name in self._entries
+
+    def __len__(self):
+        return len(self._entries)
+
+    def __iter__(self):
+        return iter(self._entries)
+
+    def keys(self):
+        """Return attribute names accepted by this policy."""
+        return self._entries.keys()
+
+    def to_dict(self, seen=None):
+        """Convert to a plain dict, suitable for JSON serialization.
+
+        Nested NlPolicy objects are expanded recursively. Cyclic
+        references are trimmed (resolved to just {"type": "nested"}).
+        """
+        if seen is None:
+            seen = set()
+        result = dict(self._props)
+        if self._policy_idx is not None:
+            if self._policy_idx not in seen:
+                seen = seen | {self._policy_idx}
+                children = {}
+                for name in self:
+                    children[name] = self[name].to_dict(seen)
+                if self._props:
+                    result['policy'] = children
+                else:
+                    result = children
+        return result
+
+    def __repr__(self):
+        return repr(self.to_dict())
 
 
 class NlAttr:
@@ -1308,28 +1389,6 @@ from .nlspec import SpecFamily
     def do_multi(self, ops):
         return self._ops(ops)
 
-    def _resolve_policy(self, policy_idx, policy_table, attr_set):
-        attrs = {}
-        if policy_idx not in policy_table:
-            return attrs
-        for attr_id, decoded in policy_table[policy_idx].items():
-            if attr_set and attr_id in attr_set.attrs_by_val:
-                spec = attr_set.attrs_by_val[attr_id]
-                name = spec['name']
-            else:
-                spec = None
-                name = f'attr-{attr_id}'
-            if 'policy-idx' in decoded:
-                sub_set = None
-                if spec and 'nested-attributes' in spec.yaml:
-                    sub_set = self.attr_sets[spec.yaml['nested-attributes']]
-                nested = self._resolve_policy(decoded['policy-idx'],
-                                              policy_table, sub_set)
-                del decoded['policy-idx']
-                decoded['policy'] = nested
-            attrs[name] = decoded
-        return attrs
-
     def get_policy(self, op_name, mode):
         """Query running kernel for the Netlink policy of an operation.
 
@@ -1341,8 +1400,8 @@ from .nlspec import SpecFamily
             mode: 'do' or 'dump'
 
         Returns:
-            NlPolicy with an attrs dict mapping attribute names to
-            their policy properties (type, min/max, nested, etc.),
+            NlPolicy acting as a read-only dict mapping attribute names
+            to their policy properties (type, min/max, nested, etc.),
             or None if the operation has no policy for the given mode.
             Empty policy usually implies that the operation rejects
             all attributes.
@@ -1353,5 +1412,4 @@ from .nlspec import SpecFamily
         if mode not in op_policy:
             return None
         policy_idx = op_policy[mode]
-        attrs = self._resolve_policy(policy_idx, policy_table, op.attr_set)
-        return NlPolicy(attrs)
+        return NlPolicy(self, policy_idx, policy_table, op.attr_set)

