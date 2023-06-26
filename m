Return-Path: <netdev+bounces-14063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0BB73EBD3
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229531C209C1
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125A714297;
	Mon, 26 Jun 2023 20:27:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617512B66
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:27:58 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0802D98
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 13:27:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98d34f1e54fso367329166b.2
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687811273; x=1690403273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWfLa4Q63sI9tMnHGZaMYw6s0jAlSkOidYot17/0NCE=;
        b=Z2BK4xMFqQVKBeiI0IisrrbmO0BKfo82803f/FltZoiy830gTy5kPseVZtlr0u/aMn
         A20ZiJ6UnUImBMuFi45eRuAFSSd3ajZ+AnsMo0unU47W9ho30RqZr8cHypV//w8f3CP2
         cDQcPffJi9hdMX7i0Hwr0QxITE3jBc0xZ1sLIYkekJa77+3gPGZkHYJvz0CNA9OczeIt
         tMPEzfKf036UL/qF3jDZ9m8pev5JQT3yqH56UrztGUnbR1HT9/0coSto+IPaADnSxF0Y
         YtNaAQmEC/Lv0llQtGNL4/3d6BAJuH+kaBIfyKT+FZrckh7ew4mZ4dBp8TML2Jp54pnv
         uJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687811273; x=1690403273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWfLa4Q63sI9tMnHGZaMYw6s0jAlSkOidYot17/0NCE=;
        b=KULr69C1f2rvP9X+BJI/Cm45Jaoldk4hMnlqjZvpKABtXmiTknU+dZ1dUpcDOC+yo6
         mMEMft9MtOFrvADmdAuvhEJOsnaI2tx0x5kL/7+bMIRMPm6YfjTiOSPoY6Uew7Pt8FH/
         AbcKs9Fcm6DsA4ETofI1na7UTxI0J3//merTCInjv79MYaf2MuMQ8FHT3gudd60UTo5c
         K3y+DRKigN9jVPM00u4bqUYuex+8P7ZCy1x1Khp1FdHgFSdfm15Iji61Jpi37ewLca0N
         lJeD9DGnQb8lqLcGVLg5bp11mf6MAMjZAPzYbqtJGmdfMTuzemX35MrwTlIZ0zRboZbM
         mjVg==
X-Gm-Message-State: AC+VfDwTqBNrS3eUTDKDWGjdoJlYgoUJ9KduKvLfbKkHpo959O8tJElT
	4qEUlvG55vubNJqW4FHAkn8=
X-Google-Smtp-Source: ACHHUZ6TgOdD7htj9Q+mm7kgl8tj+Hr0jpgaZf0L6UFyAP4ft1vdehWVPBws0NUnhrniK0OmFfY1fA==
X-Received: by 2002:a17:906:d797:b0:98d:ffdf:29cb with SMTP id pj23-20020a170906d79700b0098dffdf29cbmr3285085ejb.2.1687811273111;
        Mon, 26 Jun 2023 13:27:53 -0700 (PDT)
Received: from tycho (p200300c1c74c0400ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c74c:400:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906080200b009534211cc97sm3668779ejd.159.2023.06.26.13.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:27:52 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Mon, 26 Jun 2023 22:27:50 +0200
From: Zahari Doychev <zahari.doychev@linux.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, hmehrtens@maxlinear.com, 
	aleksander.lobakin@intel.com, simon.horman@corigine.com, idosch@idosch.org, 
	Zahari Doychev <zdoychev@maxlinear.com>
Subject: Re: [PATCH iproute2-next v2] f_flower: add cfm support
Message-ID: <6ntr2hx5dp4iq5slj76knjkne5ahkf3lhrwd7wus3p5mqjav6n@xwgnndoz4mzs>
References: <20230620201036.539994-1-zahari.doychev@linux.com>
 <20230625120341.5e738745@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625120341.5e738745@hermes.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 25, 2023 at 12:03:41PM -0700, Stephen Hemminger wrote:
> On Tue, 20 Jun 2023 22:10:36 +0200
> Zahari Doychev <zahari.doychev@linux.com> wrote:
> 
> > +	print_nl();
> > +	print_string(PRINT_FP, NULL, "  cfm", NULL);
> > +	open_json_object("cfm");
> > +
> > +	v = tb[TCA_FLOWER_KEY_CFM_MD_LEVEL];
> > +	if (v) {
> > +		sz += sprintf(out, " mdl %u", rta_getattr_u8(v));
> > +		print_hhu(PRINT_JSON, "mdl", NULL, rta_getattr_u8(v));
> > +
> > +	}
> > +
> > +	v = tb[TCA_FLOWER_KEY_CFM_OPCODE];
> > +	if (v) {
> > +		sprintf(out + sz, " op %u", rta_getattr_u8(v));
> > +		print_hhu(PRINT_JSON, "op", NULL, rta_getattr_u8(v));
> > +
> > +	}
> > +
> > +	close_json_object();
> > +	print_string(PRINT_FP, "cfm", "%s", out);
> 
> Don't think you need to format the temporary string if you do this the easy way.
> Just use print_uint?
> 	if (tb[TCA_FLOWER_KEY_CFM_MD_LEVEL])
> 		print_uint(PRINT_ANY, "mdl", " mdl %u",
> 			rta_getattr_u8(tb[TCA_FLOWER_KEY_CFM_MD_LEVEL]);
> 
> Since argument to print_uint is unsigned, the u8 will naturally get expanded.
> 

I think it will make it really simpler. I will try it out and send a new
patch as v3 was already merged.

Thanks
Zahari

