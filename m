Return-Path: <netdev+bounces-198720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96745ADD48D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25E51947ECE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0682C2ED147;
	Tue, 17 Jun 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyhWfOwV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108E2ECD33;
	Tue, 17 Jun 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176009; cv=none; b=ozclS2wtY69bwKVtCIG3QrD29JusJhWOusTQyNO+HUXQMiNf0iDgvpS10eeMtTDBiSUTh9IfioT4nUO3l8Cy4tsPELPL2ozIxd15yexYSEa5gVg0wbNlvlMJ+P2sD0KV7qxDCRmVj8ChXserPniYiFggS/5ZPyeVOyOpBg1DKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176009; c=relaxed/simple;
	bh=RyjFEiBY6VQWOdFRWsesICSXRLCWbA6jugn3H5Rqqj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKbFEmYsGevj8hnYHJPhnR25Y1ls4pJL3nBWSOurpqgRT6QB13ZEEtBIoE+Sqhr2AmR+NtamoSq2lgctRh/tdyfa7i9gxZiaZK0pAcFk3CPMLu2gBOT1UElhIFYWS49MZ0Ye2zOnA/Hmlpc4WuEncwzPfs2TiyG8+bIFyE0D4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyhWfOwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030C3C4CEF0;
	Tue, 17 Jun 2025 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176009;
	bh=RyjFEiBY6VQWOdFRWsesICSXRLCWbA6jugn3H5Rqqj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NyhWfOwVdK3L2Bb75J5vSsIdX6gOEeQSFExVwbnkPQ6fTa1GkhQLqeW4MIH0zu6ps
	 tkAmw0a7l1eXM71V0mnEYz84sMb1R+ifsYhfiZ31Z7O1RvJu3Qgu74E6apfmWeK3UM
	 C46NzCOtRELdsM7tDF4JBneKytKgKeM3tmyizqMeGRBc/YIIpWZMHPEiGqFvjHiGVM
	 X23MLpgrm5E4jt8VhfDmnaONt69UTkJO4LF8M/jwql5fqPw6mUg9ExOeqBaPj0k4fE
	 yJ0IZXWO72X7nv9fHXtPiihMPM+lxaN8P5JXGsO6br6QDedqCrOISzsewDKZsKrFuS
	 IpD9VAx/T+gPw==
Date: Tue, 17 Jun 2025 18:00:01 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "Akira Yokosawa" <akiyks@gmail.com>, "Breno Leitao"
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>, "Jan Stancek" <jstancek@redhat.com>, "Marco Elver"
 <elver@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Ruben Wauters"
 <rubenru09@aol.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v5 10/15] docs: sphinx: add a parser for yaml files for
 Netlink specs
Message-ID: <20250617180001.46931ba9@sal.lan>
In-Reply-To: <20250617154049.104ef6ff@sal.lan>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<c407d769c9f47083e8f411c13989522e32262562.1750146719.git.mchehab+huawei@kernel.org>
	<m27c1ak0k9.fsf@gmail.com>
	<20250617154049.104ef6ff@sal.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Tue, 17 Jun 2025 15:40:49 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> > > +            # Parse message with RSTParser
> > > +            for i, line in enumerate(msg.split('\n')):
> > > +                result.append(line, document.current_source, i)   =20
> >=20
> > This has the effect of associating line numbers from the generated ReST
> > with the source .yaml file, right? So errors will be reported against
> > the wrong place in the file. Is there any way to show the cause of the
> > error in the intermediate ReST? =20
>=20
> Yes, but this will require modifying the parser. I prefer merging this
> series without such change, and then having a separate changeset
> addressing it.
>=20
> There are two ways we can do that:
>=20
> 1. The parser can add a ReST comment with the line number. This
>    is what it is done by kerneldoc.py Sphinx extension:
>=20
> 	lineoffset =3D 0
> 	line_regex =3D re.compile(r"^\.\. LINENO ([0-9]+)$")
>         for line in lines:
>             match =3D line_regex.search(line)
>             if match:
>                 lineoffset =3D int(match.group(1)) - 1 # sphinx counts li=
nes from 0
>             else:
>                 doc =3D str(env.srcdir) + "/" + env.docname + ":" + str(s=
elf.lineno)
>                 result.append(line, doc + ": " + filename, lineoffset)
>                 lineoffset +=3D 1
>=20
>    I kept the same way after its conversion to Python, as right now,
>    it supports both a Python class and a command lin command. I may
>    eventually clean it up in the future.
>=20
> 2. making the parser return a tuple. At kernel_abi.py, as the parser
>    returns content from multiple files, such tuple is:
>=20
> 		 (rst_output, filename, line_number)
>=20
>    and the code for it is (cleaned up):
>=20
> 	for msg, f, ln in kernel_abi.doc(show_file=3Dshow_file,
>                                          show_symbols=3Dshow_symbols,
>                                          filter_path=3Dabi_type):
>=20
>             lines =3D statemachine.string2lines(msg, tab_width,
>                                               convert_whitespace=3DTrue)
>=20
>             for line in lines:
>                 content.append(line, f, ln - 1) # sphinx counts lines fro=
m 0
>=20
> (2) is cleaner and faster, but (1) is easier to implement on an=20
> already-existing code.

The logic below implements (1). This seems to be the easiest way for
pyyaml. I will submit as 2 separate patches at the end of the next
version.

Please notice that I didn't check yet for the "quality" of the
line numbers. Some tweaks could be needed later on.

Regards,
Mauro

---

=46rom 750daebebadcd156b5fe9b516f4fae4bd42b9d2c Mon Sep 17 00:00:00 2001
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 17:54:03 +0200
Subject: [PATCH] docs: parser_yaml.py: add support for line numbers from the
 parser

Instead of printing line numbers from the temp converted ReST
file, get them from the original source.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/par=
ser_yaml.py
index 635945e1c5ba..15c642fc0bd5 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -29,6 +29,8 @@ class YamlParser(Parser):
=20
     netlink_parser =3D YnlDocGenerator()
=20
+    re_lineno =3D re.compile(r"\.\. LINENO ([0-9]+)$")
+
     def do_parse(self, inputstring, document, msg):
         """Parse YAML and generate a document tree."""
=20
@@ -38,8 +40,14 @@ class YamlParser(Parser):
=20
         try:
             # Parse message with RSTParser
-            for i, line in enumerate(msg.split('\n')):
-                result.append(line, document.current_source, i)
+            lineoffset =3D 0;
+            for line in msg.split('\n'):
+                match =3D self.re_lineno.match(line)
+                if match:
+                    lineoffset =3D int(match.group(1))
+                    continue
+
+                result.append(line, document.current_source, lineoffset)
=20
             rst_parser =3D RSTParser()
             rst_parser.parse('\n'.join(result), document)

=46rom 15c1f9db30f3abdce110e19788d87f9fe1417781 Mon Sep 17 00:00:00 2001
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 17:28:04 +0200
Subject: [PATCH] tools: netlink_yml_parser.py: add line numbers to parsed d=
ata

When something goes wrong, we want Sphinx error to point to the
right line number from the original source, not from the
processed ReST data.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/tools/net/ynl/pyynl/netlink_yml_parser.py b/tools/net/ynl/pyyn=
l/netlink_yml_parser.py
index 866551726723..a9d8ab6f2639 100755
--- a/tools/net/ynl/pyynl/netlink_yml_parser.py
+++ b/tools/net/ynl/pyynl/netlink_yml_parser.py
@@ -20,6 +20,16 @@
 from typing import Any, Dict, List
 import yaml
=20
+LINE_STR =3D '__lineno__'
+
+class NumberedSafeLoader(yaml.SafeLoader):
+    """Override the SafeLoader class to add line number to parsed data"""
+
+    def construct_mapping(self, node):
+        mapping =3D super().construct_mapping(node)
+        mapping[LINE_STR] =3D node.start_mark.line
+
+        return mapping
=20
 class RstFormatters:
     """RST Formatters"""
@@ -127,6 +137,11 @@ class RstFormatters:
         """Return a formatted label"""
         return f".. _{title}:\n\n"
=20
+    @staticmethod
+    def rst_lineno(lineno: int) -> str:
+        """Return a lineno comment"""
+        return f".. LINENO {lineno}\n"
+
 class YnlDocGenerator:
     """YAML Netlink specs Parser"""
=20
@@ -144,6 +159,9 @@ class YnlDocGenerator:
         """Parse 'do' section and return a formatted string"""
         lines =3D []
         for key in do_dict.keys():
+            if key =3D=3D LINE_STR:
+                lines.append(self.fmt.rst_lineno(do_dict[key]))
+                continue
             lines.append(self.fmt.rst_paragraph(self.fmt.bold(key), level =
+ 1))
             if key in ['request', 'reply']:
                 lines.append(self.parse_do_attributes(do_dict[key], level =
+ 1) + "\n")
@@ -174,6 +192,10 @@ class YnlDocGenerator:
             lines.append(self.fmt.rst_paragraph(operation["doc"]) + "\n")
=20
             for key in operation.keys():
+                if key =3D=3D LINE_STR:
+                    lines.append(self.fmt.rst_lineno(operation[key]))
+                    continue
+
                 if key in preprocessed:
                     # Skip the special fields
                     continue
@@ -233,6 +255,9 @@ class YnlDocGenerator:
         for definition in defs:
             lines.append(self.fmt.rst_section(namespace, 'definition', def=
inition["name"]))
             for k in definition.keys():
+                if k =3D=3D LINE_STR:
+                    lines.append(self.fmt.rst_lineno(definition[k]))
+                    continue
                 if k in preprocessed + ignored:
                     continue
                 lines.append(self.fmt.rst_fields(k, self.fmt.sanitize(defi=
nition[k]), 0))
@@ -268,6 +293,9 @@ class YnlDocGenerator:
                 lines.append(self.fmt.rst_subsubsection(attr_line))
=20
                 for k in attr.keys():
+                    if k =3D=3D LINE_STR:
+                        lines.append(self.fmt.rst_lineno(attr[k]))
+                        continue
                     if k in preprocessed + ignored:
                         continue
                     if k in linkable:
@@ -306,6 +334,8 @@ class YnlDocGenerator:
         lines =3D []
=20
         # Main header
+        lineno =3D obj.get('__lineno__', 0)
+        lines.append(self.fmt.rst_lineno(lineno))
=20
         family =3D obj['name']
=20
@@ -354,7 +384,7 @@ class YnlDocGenerator:
     def parse_yaml_file(self, filename: str) -> str:
         """Transform the YAML specified by filename into an RST-formatted =
string"""
         with open(filename, "r", encoding=3D"utf-8") as spec_file:
-            yaml_data =3D yaml.safe_load(spec_file)
-            content =3D self.parse_yaml(yaml_data)
+            numbered_yaml =3D yaml.load(spec_file, Loader=3DNumberedSafeLo=
ader)
+            content =3D self.parse_yaml(numbered_yaml)
=20
         return content


