Return-Path: <netdev+bounces-37302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E23D7B4948
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 20:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7DEB41C2048A
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21971803F;
	Sun,  1 Oct 2023 18:51:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A30AEED3
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 18:51:13 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47893D3
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 11:51:11 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bc57401cb9so2234504a34.0
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696186270; x=1696791070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnC1cLUw1otPjc5iY/XpyFgQUai99uHbpR9mHNJU9pA=;
        b=mL6EGCliN6s/jJi2hneFQtzzQ0Eu9/54zyBvrae552NJNsTuu9V20VrHpRdTIgZ9pA
         AYudiSmdmz1ypi7ktHkxEGf+tkShocHYAjqZjTnSN8MYygkPi+R05m2RDOsBbhYtQx0W
         J86WAVq0Dlv3H8OYJyKSuo5c4Exni8DAgzqt5udVl487WnBnXvMb8a2PNarqf9ybG8Ma
         9n5mS688xavtyOvEEMCX238XcJB54L2pp+yEAnkXGPmlRkF/sIRQLt8MwIaAae3ErgLM
         iJplrq9kWXdI3nurQx5HfyETVZTvzuIHmCpjra94r5aCpA9HXi18iaE7yYWUgqxPMgw2
         K3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696186270; x=1696791070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnC1cLUw1otPjc5iY/XpyFgQUai99uHbpR9mHNJU9pA=;
        b=Y+XczoFXm19Bf/B6WQQ82a7ZlM6xbmeY/vs7Jc+0l+gF6Rf0XcA0OOCc+us+be1+8E
         Bj8hvJhA11G7fWRLgTp7luZ0WM6Ui4HEv2fW5IbWPqly62lwelvXLHOS/PoTz3v1H7H/
         it1Tqr8N8yCyQQTSfxgf/9k1fbobJYmHphFO8R61MnqOMrHo+H0W3JPpKub0+IKgVrM6
         yEeY3xT505ZwPCydO4xRB7/LPnzICHXddbWkir9EtJSgJ1r/TIi6GyYJnxAvGSB2g2aT
         62HgZy1Zj6QWYsyTL2JdtekOLNk4CzAGGUwIVp4IacG5vSit8g6+92vmeq7ex6YWUqTx
         f1KA==
X-Gm-Message-State: AOJu0YxsuKkRDCfffZxFjXhcxhE3nLRB6vcjssp75LlgKdzHoKd/Sn3F
	32HGrYWRyE33tlp2kJLHhTc=
X-Google-Smtp-Source: AGHT+IH28uNoUYGbnkyWRhkDul5Pkzl7knxhvFKmqkbVLrJ3dUPUoWX60Ds6Pq3cehWt6BwjEKDSZQ==
X-Received: by 2002:a05:6808:f92:b0:3ae:df5:6d0d with SMTP id o18-20020a0568080f9200b003ae0df56d0dmr10481660oiw.2.1696186270370;
        Sun, 01 Oct 2023 11:51:10 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b0025dc5749b4csm5338085pje.21.2023.10.01.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 11:51:09 -0700 (PDT)
Date: Sun, 1 Oct 2023 11:51:07 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Xabier Marquiegui <reibax@gmail.com>, netdev@vger.kernel.org,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
	alex.maftei@amd.com, davem@davemloft.net, rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v3 3/3] ptp: support event queue reader channel
 masks
Message-ID: <ZRm/myTwrv1MqHAn@hoboy.vegasvil.org>
References: <20230928133544.3642650-1-reibax@gmail.com>
 <20230928133544.3642650-4-reibax@gmail.com>
 <20231001151202.GQ92317@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001151202.GQ92317@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 01, 2023 at 05:12:02PM +0200, Simon Horman wrote:

> > @@ -169,19 +170,28 @@ long ptp_ioctl(struct posix_clock_user *pcuser, unsigned int cmd,
> >  {
> >  	struct ptp_clock *ptp =
> >  		container_of(pcuser->clk, struct ptp_clock, clock);
> > +	struct ptp_tsfilter tsfilter_set, *tsfilter_get = NULL;
> >  	struct ptp_sys_offset_extended *extoff = NULL;
> >  	struct ptp_sys_offset_precise precise_offset;
> >  	struct system_device_crosststamp xtstamp;
> >  	struct ptp_clock_info *ops = ptp->info;
> >  	struct ptp_sys_offset *sysoff = NULL;
> > +	struct timestamp_event_queue *tsevq;
> >  	struct ptp_system_timestamp sts;
> >  	struct ptp_clock_request req;
> >  	struct ptp_clock_caps caps;
> >  	struct ptp_clock_time *pct;
> > +	int lsize, enable, err = 0;
> >  	unsigned int i, pin_index;
> >  	struct ptp_pin_desc pd;
> >  	struct timespec64 ts;
> > -	int enable, err = 0;
> > +
> > +	tsevq = pcuser->private_clkdata;
> > +
> > +	if (tsevq->close_req) {
> > +		err = -EPIPE;
> > +		return err;
> > +	}
> 
> Here tseqv is dereferenced unconditionally...

Which is correct because the pointer is always set during open().

> 
> >  
> >  	switch (cmd) {
> >  
> > @@ -481,6 +491,79 @@ long ptp_ioctl(struct posix_clock_user *pcuser, unsigned int cmd,
> >  		mutex_unlock(&ptp->pincfg_mux);
> >  		break;
> >  
> > +	case PTP_FILTERCOUNT_REQUEST:
> > +		/* Calculate amount of device users */
> > +		if (tsevq) {
> 
> ... but here it is assumed that tseqv might be NULL.

Which is incorrect.  The test is pointless.

Thanks,
Richard

