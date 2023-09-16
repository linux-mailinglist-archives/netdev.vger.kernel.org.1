Return-Path: <netdev+bounces-34287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0167A308F
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41212823EA
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 13:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51B13AD9;
	Sat, 16 Sep 2023 13:11:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0CE1C33
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 13:11:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A7BC1B2
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694869888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/f7x5W/7+el4/b4gP9Yv5ZU0CBNXGpFkYpOe/dJLJQ=;
	b=MPEtGqZla9Kk9YXd9yNqZG8YP46NgxTiCehl+W3zLEhnOQF1gXmiEWCO3A1AXVb5MHix3L
	/cHv2qzwvSZ+27EEKUlPpq49iQ3Y2AR8QPKY06RFLgVxoOuMFfYNjIlzEhkFoJofVhHGsT
	MTquYAWPUeoxBWmSUYfw2UqRpDawKs0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-v-L-zoJUMKyJDB7XZMdKfQ-1; Sat, 16 Sep 2023 09:11:27 -0400
X-MC-Unique: v-L-zoJUMKyJDB7XZMdKfQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40474c03742so18378395e9.3
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 06:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694869885; x=1695474685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/f7x5W/7+el4/b4gP9Yv5ZU0CBNXGpFkYpOe/dJLJQ=;
        b=uaY68FgV4tRpwDluEr0ot8hT6TscoLH+F+U1/GhW7OjLiXuaga17Z1i0mb0h9WdV23
         AFYFele4DXo94qQz59RicMJGxf50tAx821acPiXC9+J6tAnFA+XGKpOreVQCwamst5fW
         ejwCUmJJw1HNBROYMq0MzzoYVmS8q6IzItr4sOzdPRgVCETwfkIuUvujvw7JruVMPT3N
         /tR5kR/Ae2nTtRo3Goalzi1mG+oNi3ZqRTgZko/ro2291rCBLRqoL35d42kVrXJ69K8L
         x5UF/xjUuqxJn+S5VmNJoJNpgpICdNAvdA900cxVM9B22z3F+Qst+LiJToTbSgNrZE9F
         aboA==
X-Gm-Message-State: AOJu0YycoelOIV4ME1NEB4PcymEpD9he45yvgODjJPmnlter0M2nEfZu
	Pkx81+KBa3K0BroB33NivGVCxERzgCDj03P1HrN7thW0DQUieXdsWrbXrt363e+bDYehL1UogTW
	XfdIsAJDoAxNnwfw+RlXC21Sj
X-Received: by 2002:adf:f20a:0:b0:31f:e74d:c82a with SMTP id p10-20020adff20a000000b0031fe74dc82amr3448223wro.31.1694869885703;
        Sat, 16 Sep 2023 06:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw6K2rb/YyoBY7t7d9xPksJuuBd/JceFOp3q0Hka9x4ZlDF+UhYOsP/EkWiPD3CoWJJZ6HNw==
X-Received: by 2002:adf:f20a:0:b0:31f:e74d:c82a with SMTP id p10-20020adff20a000000b0031fe74dc82amr3448210wro.31.1694869885277;
        Sat, 16 Sep 2023 06:11:25 -0700 (PDT)
Received: from localhost ([37.163.16.17])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5248000000b0031fc4c31d77sm7150996wrc.88.2023.09.16.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 06:11:24 -0700 (PDT)
Date: Sat, 16 Sep 2023 15:11:20 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] allow overriding color option in
 environment
Message-ID: <ZQWpeN7EbJX5QI6h@renaissance-vector>
References: <20230915210700.83077-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230915210700.83077-1-stephen@networkplumber.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 02:07:00PM -0700, Stephen Hemminger wrote:
> For ip, tc, and bridge command introduce a new way to enable
> automatic colorization via environment variable. The default
> is what ever is in the config.
> 
> Example:
>   $ IP_COLOR=auto ip -br show addr
> 
> The idea is that distributions can ship with the same default
> as before "none" but that users can override if needed
> without resorting to aliasing every command.
> 

I'm OK with this, but can we please use a single environment variable to
control color output for all iproute tools? I can't see why anyone would
want to have color output on by default for ip and not for tc and
bridge...

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  bridge/bridge.c   |  2 +-
>  include/color.h   |  1 +
>  ip/ip.c           |  2 +-
>  lib/color.c       | 36 +++++++++++++++++++++++++++---------
>  man/man8/bridge.8 |  7 +++++++
>  man/man8/ip.8     | 14 +++++++++-----
>  man/man8/tc.8     |  6 ++++++
>  tc/tc.c           |  2 +-
>  8 files changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/bridge/bridge.c b/bridge/bridge.c
> index 339101a874b1..f9a245cb3670 100644
> --- a/bridge/bridge.c
> +++ b/bridge/bridge.c
> @@ -102,7 +102,7 @@ static int batch(const char *name)
>  int
>  main(int argc, char **argv)
>  {
> -	int color = CONF_COLOR;
> +	int color = default_color("BRIDGE_COLOR");
>  
>  	while (argc > 1) {
>  		const char *opt = argv[1];
> diff --git a/include/color.h b/include/color.h
> index 17ec56f3d7b4..8eea534f38e1 100644
> --- a/include/color.h
> +++ b/include/color.h
> @@ -20,6 +20,7 @@ enum color_opt {
>  	COLOR_OPT_ALWAYS = 2
>  };
>  
> +int default_color(const char *argv0);
>  bool check_enable_color(int color, int json);
>  bool matches_color(const char *arg, int *val);
>  int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...);
> diff --git a/ip/ip.c b/ip/ip.c
> index 860ff957c3b3..e15d5fe52d92 100644
> --- a/ip/ip.c
> +++ b/ip/ip.c
> @@ -168,7 +168,7 @@ int main(int argc, char **argv)
>  	const char *libbpf_version;
>  	char *batch_file = NULL;
>  	char *basename;
> -	int color = CONF_COLOR;
> +	int color = default_color("IP_COLOR");
>  
>  	/* to run vrf exec without root, capabilities might be set, drop them
>  	 * if not needed as the first thing.
> diff --git a/lib/color.c b/lib/color.c
> index 59976847295c..9a579f34977d 100644
> --- a/lib/color.c
> +++ b/lib/color.c
> @@ -93,6 +93,32 @@ bool check_enable_color(int color, int json)
>  	return false;
>  }
>  
> +static bool match_color_value(const char *arg, int *val)
> +{
> +	if (*arg == '\0' || !strcmp(arg, "always"))

This actually produces an unexpected result.

IP_COLOR= ip address

results in colorized output, while it should be colorless, in my
opinion. However this works ok when this code path is exercised by the
'--color' option, as with:

ip -c address

users actually expect to have color on the output.

> +		*val = COLOR_OPT_ALWAYS;
> +	else if (!strcmp(arg, "auto"))
> +		*val = COLOR_OPT_AUTO;
> +	else if (!strcmp(arg, "never"))
> +		*val = COLOR_OPT_NEVER;
> +	else
> +		return false;
> +	return true;
> +}
> +
> +int default_color(const char *env)
> +{
> +	char *name;
> +	int val;
> +	size_t i;
> +

You may want to get rid of the i var above:

color.c: In function ‘default_color’:
color.c:113:16: warning: unused variable ‘i’ [-Wunused-variable]
  113 |         size_t i;
      |                ^

> +	name = getenv(env);
> +	if (name && match_color_value(name, &val))
> +		return val;
> +
> +	return CONF_COLOR;
> +}
> +
>  bool matches_color(const char *arg, int *val)
>  {
>  	char *dup, *p;
> @@ -108,15 +134,7 @@ bool matches_color(const char *arg, int *val)
>  	if (matches(dup, "-color"))
>  		return false;
>  
> -	if (*p == '\0' || !strcmp(p, "always"))
> -		*val = COLOR_OPT_ALWAYS;
> -	else if (!strcmp(p, "auto"))
> -		*val = COLOR_OPT_AUTO;
> -	else if (!strcmp(p, "never"))
> -		*val = COLOR_OPT_NEVER;
> -	else
> -		return false;
> -	return true;
> +	return match_color_value(p, val);
>  }
>  
>  static void set_color_palette(void)
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index c52c9331e2c2..58bb1ddbd26a 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -319,6 +319,13 @@ precedence. This flag is ignored if
>  .B \-json
>  is also given.
>  
> +
> +The default color setting is
> +.B never
> +but can be overridden by the
> +.B BRIDGE_COLOR
> +environment variable.
> +
>  .TP
>  .BR "\-j", " \-json"
>  Output results in JavaScript Object Notation (JSON).
> diff --git a/man/man8/ip.8 b/man/man8/ip.8
> index 72227d44fd30..df572f47d96d 100644
> --- a/man/man8/ip.8
> +++ b/man/man8/ip.8
> @@ -197,11 +197,15 @@ precedence. This flag is ignored if
>  .B \-json
>  is also given.
>  
> -Used color palette can be influenced by
> -.BR COLORFGBG
> -environment variable
> -(see
> -.BR ENVIRONMENT ).
> +The default color setting is
> +.B never
> +but can be overridden by the
> +.B IP_COLOR
> +environment variable.
> +
> +The color palette used can be adjusted with
> +.B COLORFGBG
> +environment variable.
>  
>  .TP
>  .BR "\-t" , " \-timestamp"
> diff --git a/man/man8/tc.8 b/man/man8/tc.8
> index d436d46472af..39ac6dcd1631 100644
> --- a/man/man8/tc.8
> +++ b/man/man8/tc.8
> @@ -805,6 +805,12 @@ precedence. This flag is ignored if
>  .B \-json
>  is also given.
>  
> +The default color setting is
> +.B never
> +but can be overridden by the
> +.B TC_COLOR
> +environment variable.
> +
>  .TP
>  .BR "\-j", " \-json"
>  Display results in JSON format.
> diff --git a/tc/tc.c b/tc/tc.c
> index 082c6677d34a..b7cd60d68a38 100644
> --- a/tc/tc.c
> +++ b/tc/tc.c
> @@ -253,7 +253,7 @@ int main(int argc, char **argv)
>  {
>  	const char *libbpf_version;
>  	char *batch_file = NULL;
> -	int color = CONF_COLOR;
> +	int color = default_color("TC_COLOR");
>  	int ret;
>  
>  	while (argc > 1) {
> -- 
> 2.39.2
> 


