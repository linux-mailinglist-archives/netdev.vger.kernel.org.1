Return-Path: <netdev+bounces-17483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785BC751C5A
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338FD281C55
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E966DF4C;
	Thu, 13 Jul 2023 08:56:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1BF9D1
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:56:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77811FC9
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689238603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMXeViDh81KdrQAvOOFtZr+HuB4EpGkDeqzskTPNfNI=;
	b=MSxniSJtEJGnxOr3f2NkZh7ZqxziNobJbsTSncgCMkNKweZ3Lo9Ul4Ge/cvVtaKsaZvNFb
	mc0snYDbWoxBflifSV9BkknDLV36oh4IuIGmSrctLcZWDRjYgxHkyHSJ7Ch9jo6OXCNUtF
	XR9znvFP53HEblEaOtaHarbZTZ2oLbU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-ZM8ntdJgOOO4evgjWQb8rw-1; Thu, 13 Jul 2023 04:56:42 -0400
X-MC-Unique: ZM8ntdJgOOO4evgjWQb8rw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635eb5b04e1so1274896d6.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689238602; x=1689843402;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMXeViDh81KdrQAvOOFtZr+HuB4EpGkDeqzskTPNfNI=;
        b=JffcM0mDeyrqEl+qKXjKf2bOMqR0dow86NcySx4MVHBTlJwBBiwOxue2qE+Z5xqypY
         ohtWhPUUDid6OuHi/eotgTPVAd8duELctc0AmEEGpHuUw/k9IMHAJac7OODynHrMHWqH
         2Btfz+hIdj5FRpKvmyi6s4+DFNau7XLtr9Gj6OlWUco67CvZoY7Po9SSQr85tuPIfK2S
         jwoHZLfAHthefPFAsZWXVjsk93/GoQDcwaeSsADa/fwIXkrsHsS6iabFzixRLatqJz+N
         3aE+TeE0xeHoSyiZINpwnpi2V2+hnKLbAzsBQWIoCUn8bBn2OOkWpHkxU5k4ib6C1ZLW
         Z/Yg==
X-Gm-Message-State: ABy/qLZX+CJFDldMJpQ0Dc5Z07mBtr80FluUlpOYfR+rUcg2wDwr3Ajy
	SByPEU2NSeSlcpFns627r7W5ZFouWlNEvwWZtmhVntHGXseGMu1AAde4A/ql2b4vAHJnxrwBxHX
	+rJ7ukfQTTHyixeSi
X-Received: by 2002:a05:620a:40c9:b0:767:170d:887a with SMTP id g9-20020a05620a40c900b00767170d887amr1253087qko.2.1689238601793;
        Thu, 13 Jul 2023 01:56:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHOlvMZJJ0hffk1oajklevjSqdPHVAHdO7zu054C+AAKdLK4AFaP8xDhBK70BiH1J2evNVwBg==
X-Received: by 2002:a05:620a:40c9:b0:767:170d:887a with SMTP id g9-20020a05620a40c900b00767170d887amr1252995qko.2.1689238600010;
        Thu, 13 Jul 2023 01:56:40 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a130c00b007339c5114a9sm2743606qkj.103.2023.07.13.01.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 01:56:39 -0700 (PDT)
Message-ID: <8932a16e60edf5b7cc50dcc853da0af5c73fb9a3.camel@redhat.com>
Subject: Re: [PATCH net v3 3/4] net/sched: sch_qfq: account for stab
 overhead in qfq_enqueue
From: Paolo Abeni <pabeni@redhat.com>
To: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shuah@kernel.org,  shaozhengchao@huawei.com, victor@mojatatu.com,
 simon.horman@corigine.com,  paolo.valente@unimore.it, Lion
 <nnamrec@gmail.com>
Date: Thu, 13 Jul 2023 10:56:35 +0200
In-Reply-To: <20230711210103.597831-4-pctammela@mojatatu.com>
References: <20230711210103.597831-1-pctammela@mojatatu.com>
	 <20230711210103.597831-4-pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-11 at 18:01 -0300, Pedro Tammela wrote:
> Lion says:
> -------

For the records, I feared the above separator could confuse git am -
dropping the remaining part of the commit message - but empirical
testing showed no issues;).

Cheers,

Paolo


