Return-Path: <netdev+bounces-20984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37817620DA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D421C20F88
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FD725934;
	Tue, 25 Jul 2023 18:02:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466823BF5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:02:00 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129F32695
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:01:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so3430024b3a.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690308111; x=1690912911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcsqhgZ9C8JyqTNAOoW4Lk0pIyJk2Oue9Yqg7nwRJvk=;
        b=HVA9rmU2lZz30GyVCzryofkqapIK2Y3dapBKR4mLwF7LLaBwc7fvN5QXoqDWFN4Iup
         Sfuc9ZbLcAsMONLNSOSOXOhs0ceEHMiszCE02ZlUqfq6uRjSmBehk92N2GOQWNHJAU/C
         +guVwsBvaSkd9kyq57Lmo/+dhRyVUX1IJ3yMN2vp/8SOrAQQjs2z4e102LNwyV7RmRIg
         MqneYP54Gf+wDZSfsSWUUCh2w7gxbgcvbF+o5FJ+wo+UiGA8UC7R3HKBGf/CsTeQd0OJ
         5lPhmszvGiCJCaafFenag4G4bNNOYnxR8e+rQYy3F10HlOBVP3s21T14zAycEAdwBxfw
         jFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308111; x=1690912911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcsqhgZ9C8JyqTNAOoW4Lk0pIyJk2Oue9Yqg7nwRJvk=;
        b=gRtUlemIwvkzAo/zkwDcDBaYYdRgqo1W4tyipThYd4ydJwbf/m0dBizIL4qVjOpSHv
         cuk4OITA4YfnQ9uqhP6YyszPoEB85n9LxbFn2ojSIObw9HokjKrge68E6hekOJfZeMkQ
         DYSYlWiBOe2Oyd4DVGF7p1wgPOOsfYS3KPRClWKuRtlOZMbePHvnTrjgjkM0Nz5TLoee
         g32hBQ/gR3WbEDbXCmOUEGkUoxSZhuBQUgUebKxCTlCabT0nRUkJL/sYU/rNxDxPuZ7w
         BdvlrTVTfXis2UFyNPMBCxJShbefJrAqM0GC2Let4GltC1AdTBy5HjJ2sHbfyLJHqtms
         b5bA==
X-Gm-Message-State: ABy/qLbgwY19wAjApbXu1RNFfTcpxrRJBdbkaX16/cLitOwDNxfpAXZ+
	NLDgGGB+zB4S8xbKi8HRhJ5SrAMSowbFduF/00KVUA==
X-Google-Smtp-Source: APBJJlHyRO8grTxKL9uGSdrtZsoYQS/4F+lpghDE7SbvoqAwFWBvS9e1yNDFV8T6Uy1eZ4q/Ib5YBA==
X-Received: by 2002:a05:6a00:1994:b0:686:be77:431c with SMTP id d20-20020a056a00199400b00686be77431cmr11369pfl.13.1690308108456;
        Tue, 25 Jul 2023 11:01:48 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id h14-20020aa786ce000000b00686bef8e55csm24473pfo.39.2023.07.25.11.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 11:01:48 -0700 (PDT)
Date: Tue, 25 Jul 2023 11:01:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gioele Barabucci <gioele@svario.it>
Cc: netdev@vger.kernel.org
Subject: Re: [iproute2 v3] Read configuration files from /etc and /usr
Message-ID: <20230725110146.26584f9a@hermes.local>
In-Reply-To: <20230725142759.169725-1-gioele@svario.it>
References: <20230725142759.169725-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 25 Jul 2023 16:27:59 +0200
Gioele Barabucci <gioele@svario.it> wrote:

> @@ -2924,7 +2926,9 @@ static int bpf_elf_ctx_init(struct bpf_elf_ctx *ctx, const char *pathname,
>  	}
>  
>  	bpf_save_finfo(ctx);
> -	bpf_hash_init(ctx, CONFDIR "/bpf_pinning");
> +	ret = bpf_hash_init(ctx, CONF_USR_DIR "/bpf_pinning");
> +	if (ret == -ENOENT)
> +		bpf_hash_init(ctx, CONF_ETC_DIR "/bpf_pinning");
>  

Luca spotted this one, other places prefer /etc over /use but in BPF it is swapped?

> -static void
> +static int
>  rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
>  {
>  	struct rtnl_hash_entry *entry;
> @@ -67,14 +69,14 @@ rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
>  
>  	fp = fopen(file, "r");
>  	if (!fp)
> -		return;
> +		return -errno;
>  
>  	while ((ret = fread_id_name(fp, &id, &namebuf[0]))) {
>  		if (ret == -1) {
>  			fprintf(stderr, "Database %s is corrupted at %s\n",
>  					file, namebuf);
>  			fclose(fp);
> -			return;
> +			return -1;

Having some errors return -errno and others return -1 is confusing.
Perhaps -EINVAL?

> +static void
> +rtnl_tabhash_initialize_dir(const char *ddir, void *tabhash, const int size,
> +                            const bool is_tab)
> +{
> +	char dirpath_usr[PATH_MAX], dirpath_etc[PATH_MAX];
> +	struct dirent *de;
> +	DIR *d;
> +
> +	snprintf(dirpath_usr, sizeof(dirpath_usr), "%s/%s", CONF_USR_DIR, ddir);
> +	snprintf(dirpath_etc, sizeof(dirpath_etc), "%s/%s", CONF_ETC_DIR, ddir);
> +
> +	/* load /usr/lib/iproute2/foo.d/X conf files, unless /etc/iproute2/foo.d/X exists */
> +	d = opendir(dirpath_usr);
> +	while (d && (de = readdir(d)) != NULL) {
> +		char path[PATH_MAX];
> +		size_t len;
> +		struct stat sb;
> +
> +		if (*de->d_name == '.')
> +			continue;
> +
> +		/* only consider filenames ending in '.conf' */
> +		len = strlen(de->d_name);
> +		if (len <= 5)
> +			continue;
> +		if (strcmp(de->d_name + len - 5, ".conf"))
> +			continue;
> +
> +		/* only consider filenames not present in /etc */
> +		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
> +		if (lstat(path, &sb) == 0)
> +			continue;

Do you want lstat() it will return 0 it is a symlink to non existent target.

> +		/* load the conf file in /etc */
> +		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
> +		if (is_tab)
> +			rtnl_tab_initialize(path, (char**)tabhash, size);
> +		else
> +			rtnl_hash_initialize(path, (struct rtnl_hash_entry**)tabhash, size);

I would prefer that generic function not loose all type information.
Maybe using a union for the two possible usages? Or type specific callback instead of is_tab.



