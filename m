Return-Path: <netdev+bounces-30907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F60789C87
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 11:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868BE1C20955
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D94430;
	Sun, 27 Aug 2023 09:12:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240317E4
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 09:12:53 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC418B5
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 02:12:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3ff5ddb4329so20001005e9.0
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693127569; x=1693732369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHWW4uMtxKy6RhvuAwVjGiziVG4z3L88pKFy3gfzDUY=;
        b=ED44fLllLoNApxAuowS5QHZMQoDtY9ngzD0uX5v9x6++VTFVZX0jN4/0xIzU7r+hvA
         hZuzUNr/vM35twC4/Y94t9k52ss0ef2aMEvF61hvBAIEKhfhODuCMqu+yNUP7d2FWYbR
         08iE9uWM6fPcugqE53dYSKj7p4kYnIyMfXk6xWMoAOunc7PhqSXny9VEKSxlODS/KN8r
         ixLFNdX5/RLKGV7kSsr1kO5z1zAtld47R3+d6mW5lQrNsQZAgCg1qM0rVIVFQWvF4hx+
         FV8e/X2V7ktBx0DdPD3RduUq795OT6nfLyRUf6pdNbT1GCEmUmr3W0LAFqJ1qAXwyirp
         JfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693127569; x=1693732369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHWW4uMtxKy6RhvuAwVjGiziVG4z3L88pKFy3gfzDUY=;
        b=ay/RdGLxBT1695V+QlO2QLlrCkypgpWzrCi4DUHS8ZvnHjZ/uyFm0dpSimt5S9NVoC
         jzuU5tWodMX3BatfLn21r74OyFZcabg1rR+rcC/ELaCwG/yU20YdSBK74ymTWQNRlWGL
         gv7p42+1X+7k6F2+0ivhstrRl0nBWNYbb5oPZAKARSstDxwTj1QQvKosNXlMNUyPNWjy
         sVXRxMgbcF6Mjdu/A7syPI8t/BVwrov0p/Z0H2wxjC+Yg3xdZm29PemZ6tVIac4e1bQi
         V9xd0+AtgPLkYKHfUeQlGNI9/a7/isk3cxxEvizNCFPmxrkRXOPbXzbIdmXRlHoZMUCi
         oFDQ==
X-Gm-Message-State: AOJu0Yz/viomxbsfcUagpzWnHocWdDxmDxjKFsgGRtdiFX4JMyZpUVCe
	BDMaW0lz7pqwtLB448YeOQvoc1dlU+beMDqLNrjLfg==
X-Google-Smtp-Source: AGHT+IHuyck5aZuukz9UzM9LHHAWO7UHPvlt55QXywQlTM3kLKQNunamPNQ+yj1Dv/i1VRd75uRxOw==
X-Received: by 2002:a05:600c:2491:b0:3fe:da37:d59 with SMTP id 17-20020a05600c249100b003feda370d59mr8360695wms.4.1693127569142;
        Sun, 27 Aug 2023 02:12:49 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b003fee7b67f67sm7208539wmm.31.2023.08.27.02.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 02:12:48 -0700 (PDT)
Date: Sun, 27 Aug 2023 11:12:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] tools: ynl-gen: fix uAPI generation after
 tempfile changes
Message-ID: <ZOsTj6X5jNWSobbK@nanopsycho>
References: <20230824212431.1683612-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824212431.1683612-1-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 24, 2023 at 11:24:31PM CEST, kuba@kernel.org wrote:
>We use a tempfile for code generation, to avoid wiping the target
>file out if the code generator crashes. File contents are copied
>from tempfile to actual destination at the end of main().
>
>uAPI generation is relatively simple so when generating the uAPI
>header we return from main() early, and never reach the "copy code
>over" stage. Since commit under Fixes uAPI headers are not updated
>by ynl-gen.

Ah, I missed that part, sorry. My python is not so fluent :)

>
>Move the copy/commit of the code into CodeWriter, to make it
>easier to call at any point in time. Hook it into the destructor
>to make sure we don't miss calling it.
>
>Fixes: f65f305ae008 ("tools: ynl-gen: use temporary file for rendering")
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>CC: jiri@resnulli.us
>---
> tools/net/ynl/ynl-gen-c.py | 30 ++++++++++++++++++++----------
> 1 file changed, 20 insertions(+), 10 deletions(-)
>
>diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
>index 9209bdcca9c6..897af958cee8 100755
>--- a/tools/net/ynl/ynl-gen-c.py
>+++ b/tools/net/ynl/ynl-gen-c.py
>@@ -1045,14 +1045,30 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
> 
> 
> class CodeWriter:
>-    def __init__(self, nlib, out_file):
>+    def __init__(self, nlib, out_file=None):
>         self.nlib = nlib
> 
>         self._nl = False
>         self._block_end = False
>         self._silent_block = False
>         self._ind = 0
>-        self._out = out_file
>+        if out_file is None:
>+            self._out = os.sys.stdout
>+        else:
>+            self._out = tempfile.TemporaryFile('w+')
>+            self._out_file = out_file
>+
>+    def __del__(self):
>+        self.close_out_file()
>+
>+    def close_out_file(self):
>+        if self._out == os.sys.stdout:
>+            return
>+        with open(self._out_file, 'w+') as out_file:
>+            self._out.seek(0)
>+            shutil.copyfileobj(self._out, out_file)
>+            self._out.close()
>+        self._out = os.sys.stdout
> 
>     @classmethod
>     def _is_cond(cls, line):
>@@ -2313,11 +2329,9 @@ _C_KW = {
>     parser.add_argument('--source', dest='header', action='store_false')
>     parser.add_argument('--user-header', nargs='+', default=[])
>     parser.add_argument('--exclude-op', action='append', default=[])
>-    parser.add_argument('-o', dest='out_file', type=str)
>+    parser.add_argument('-o', dest='out_file', type=str, default=None)
>     args = parser.parse_args()
> 
>-    tmp_file = tempfile.TemporaryFile('w+') if args.out_file else os.sys.stdout
>-
>     if args.header is None:
>         parser.error("--header or --source is required")
> 
>@@ -2341,7 +2355,7 @@ _C_KW = {
>         print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
>         os.sys.exit(1)
> 
>-    cw = CodeWriter(BaseNlLib(), tmp_file)
>+    cw = CodeWriter(BaseNlLib(), args.out_file)
> 
>     _, spec_kernel = find_kernel_root(args.spec)
>     if args.mode == 'uapi' or args.header:
>@@ -2590,10 +2604,6 @@ _C_KW = {
>     if args.header:
>         cw.p(f'#endif /* {hdr_prot} */')
> 
>-    if args.out_file:
>-        out_file = open(args.out_file, 'w+')
>-        tmp_file.seek(0)
>-        shutil.copyfileobj(tmp_file, out_file)
> 
> if __name__ == "__main__":
>     main()
>-- 
>2.41.0
>

