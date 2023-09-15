Return-Path: <netdev+bounces-34193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D2A7A28FA
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 23:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898FD281F30
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09671B280;
	Fri, 15 Sep 2023 21:07:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DAB11CAA
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 21:07:14 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA22A0
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:07:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fb85afef4so2517673b3a.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694812032; x=1695416832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=98RVZwvmdU1VSbM8GE5ZUFyMlgRcKtRowx1EanT3xXc=;
        b=x5r5E3Y0AjG3O6XK4sHnI8iKg/HPMfGG+mQkvu/TeMYbhofMJqETScd88r/fF3SZMb
         j8jgbAClCuQVP+22mPQStxppa2jnDAdLmge+UgS/Daf58BMphx8BRjNqyKlEBRoXk52H
         IZSpcJwoeu6iT/lX7TB0E5iRzS6/3vmBSYF/9XvUBLd8miKwSvqAGRU/6mMmpWk9G+Jk
         k80dUOHWkQGy+fQDLE9/Uq0nex7mTMD8N6jn1kWdkqzw4iZlEmkZ/aBsSf4RkcUXB5yI
         gAlcIDU+F8DRX0DjDqTyYyqREssWdtkV3Ud0L35+2MIi6ctd75WO4BZ3kM6pnUx2hLLV
         nN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812032; x=1695416832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98RVZwvmdU1VSbM8GE5ZUFyMlgRcKtRowx1EanT3xXc=;
        b=aPiHQHeVHPREHMZVqS1SuCSTE6aYZ2IZFp9rf1gv3SPsAeuajfq8qw+uCU25ZAQ+NP
         KyU04Gh6epUbe2uLTn5BgEyf2MKyo4354ekFfcWyOlqQ/QYqCo2bSEMioadFgwsGFIxM
         c9bV6TXxLeDJD75JF0njMDTGzayrXB0e/rdmSMlynb/HDGmuO3ocYpbxSwF3iQaYMwjn
         Z4F0f1s225vl1Rtg+NC2+dSiz4lGFYG+Mou/BcTKcZKc9PijpDXEIn6JwDrPWZiFTz+i
         AwCnpQ/WhUIfR2kkzH82GIBiKL5wwybaurlo2XxF7a9nCqq6aBgz/qSsCuBkdGQ8VzqP
         IJmQ==
X-Gm-Message-State: AOJu0YyjMiApjdYX+2XEOoxqgbJx3oLzYe8hfkZIP6NfCmyEvQ/TinzL
	VRQjPDP/Ph9kVZ5PR5efpFmYzfMGVTNaolYZQBU=
X-Google-Smtp-Source: AGHT+IGYvQWXCqI9YxYxkbczs84DnYxSTgNSqsuWLMmxWjlChxiBBBihmyXdFsT8lDEni/i8XbzfYw==
X-Received: by 2002:a05:6a00:22d0:b0:690:4362:7011 with SMTP id f16-20020a056a0022d000b0069043627011mr3091939pfj.24.1694812032280;
        Fri, 15 Sep 2023 14:07:12 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id ff16-20020a056a002f5000b0068fedfe01fesm3363788pfb.161.2023.09.15.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:07:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] allow overriding color option in environment
Date: Fri, 15 Sep 2023 14:07:00 -0700
Message-Id: <20230915210700.83077-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For ip, tc, and bridge command introduce a new way to enable
automatic colorization via environment variable. The default
is what ever is in the config.

Example:
  $ IP_COLOR=auto ip -br show addr

The idea is that distributions can ship with the same default
as before "none" but that users can override if needed
without resorting to aliasing every command.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 bridge/bridge.c   |  2 +-
 include/color.h   |  1 +
 ip/ip.c           |  2 +-
 lib/color.c       | 36 +++++++++++++++++++++++++++---------
 man/man8/bridge.8 |  7 +++++++
 man/man8/ip.8     | 14 +++++++++-----
 man/man8/tc.8     |  6 ++++++
 tc/tc.c           |  2 +-
 8 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index 339101a874b1..f9a245cb3670 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -102,7 +102,7 @@ static int batch(const char *name)
 int
 main(int argc, char **argv)
 {
-	int color = CONF_COLOR;
+	int color = default_color("BRIDGE_COLOR");
 
 	while (argc > 1) {
 		const char *opt = argv[1];
diff --git a/include/color.h b/include/color.h
index 17ec56f3d7b4..8eea534f38e1 100644
--- a/include/color.h
+++ b/include/color.h
@@ -20,6 +20,7 @@ enum color_opt {
 	COLOR_OPT_ALWAYS = 2
 };
 
+int default_color(const char *argv0);
 bool check_enable_color(int color, int json);
 bool matches_color(const char *arg, int *val);
 int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...);
diff --git a/ip/ip.c b/ip/ip.c
index 860ff957c3b3..e15d5fe52d92 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 	const char *libbpf_version;
 	char *batch_file = NULL;
 	char *basename;
-	int color = CONF_COLOR;
+	int color = default_color("IP_COLOR");
 
 	/* to run vrf exec without root, capabilities might be set, drop them
 	 * if not needed as the first thing.
diff --git a/lib/color.c b/lib/color.c
index 59976847295c..9a579f34977d 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -93,6 +93,32 @@ bool check_enable_color(int color, int json)
 	return false;
 }
 
+static bool match_color_value(const char *arg, int *val)
+{
+	if (*arg == '\0' || !strcmp(arg, "always"))
+		*val = COLOR_OPT_ALWAYS;
+	else if (!strcmp(arg, "auto"))
+		*val = COLOR_OPT_AUTO;
+	else if (!strcmp(arg, "never"))
+		*val = COLOR_OPT_NEVER;
+	else
+		return false;
+	return true;
+}
+
+int default_color(const char *env)
+{
+	char *name;
+	int val;
+	size_t i;
+
+	name = getenv(env);
+	if (name && match_color_value(name, &val))
+		return val;
+
+	return CONF_COLOR;
+}
+
 bool matches_color(const char *arg, int *val)
 {
 	char *dup, *p;
@@ -108,15 +134,7 @@ bool matches_color(const char *arg, int *val)
 	if (matches(dup, "-color"))
 		return false;
 
-	if (*p == '\0' || !strcmp(p, "always"))
-		*val = COLOR_OPT_ALWAYS;
-	else if (!strcmp(p, "auto"))
-		*val = COLOR_OPT_AUTO;
-	else if (!strcmp(p, "never"))
-		*val = COLOR_OPT_NEVER;
-	else
-		return false;
-	return true;
+	return match_color_value(p, val);
 }
 
 static void set_color_palette(void)
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index c52c9331e2c2..58bb1ddbd26a 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -319,6 +319,13 @@ precedence. This flag is ignored if
 .B \-json
 is also given.
 
+
+The default color setting is
+.B never
+but can be overridden by the
+.B BRIDGE_COLOR
+environment variable.
+
 .TP
 .BR "\-j", " \-json"
 Output results in JavaScript Object Notation (JSON).
diff --git a/man/man8/ip.8 b/man/man8/ip.8
index 72227d44fd30..df572f47d96d 100644
--- a/man/man8/ip.8
+++ b/man/man8/ip.8
@@ -197,11 +197,15 @@ precedence. This flag is ignored if
 .B \-json
 is also given.
 
-Used color palette can be influenced by
-.BR COLORFGBG
-environment variable
-(see
-.BR ENVIRONMENT ).
+The default color setting is
+.B never
+but can be overridden by the
+.B IP_COLOR
+environment variable.
+
+The color palette used can be adjusted with
+.B COLORFGBG
+environment variable.
 
 .TP
 .BR "\-t" , " \-timestamp"
diff --git a/man/man8/tc.8 b/man/man8/tc.8
index d436d46472af..39ac6dcd1631 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -805,6 +805,12 @@ precedence. This flag is ignored if
 .B \-json
 is also given.
 
+The default color setting is
+.B never
+but can be overridden by the
+.B TC_COLOR
+environment variable.
+
 .TP
 .BR "\-j", " \-json"
 Display results in JSON format.
diff --git a/tc/tc.c b/tc/tc.c
index 082c6677d34a..b7cd60d68a38 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -253,7 +253,7 @@ int main(int argc, char **argv)
 {
 	const char *libbpf_version;
 	char *batch_file = NULL;
-	int color = CONF_COLOR;
+	int color = default_color("TC_COLOR");
 	int ret;
 
 	while (argc > 1) {
-- 
2.39.2


