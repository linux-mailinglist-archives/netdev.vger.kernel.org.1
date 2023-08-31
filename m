Return-Path: <netdev+bounces-31560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984178EC54
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629491C209C3
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8E9447;
	Thu, 31 Aug 2023 11:41:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB559444
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:41:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D415E5C
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693482075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnuQHzAIFGo0WZruZWqfRWGANCb/aDF+514/VQ3/nGA=;
	b=X4O12gA9KSzdfT57lRjxtwfNRlZl+z0UhMjcOZ4Gm8eUhK/yDJ37y5G7imjB3shafUBedk
	LmI7VAq1q5eZRPXQQkEkWLk6tysFal0tbZDwXngpVo44a6xU0QW2MtG4RbvU3spMDJ+Z/F
	v4bhEYzwGP/5y4lgHkrYw0T5DCi+q0U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-MZ2iyejRNQuo5FiWKY4oOg-1; Thu, 31 Aug 2023 07:41:14 -0400
X-MC-Unique: MZ2iyejRNQuo5FiWKY4oOg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a5b578b1c1so9060866b.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693482072; x=1694086872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnuQHzAIFGo0WZruZWqfRWGANCb/aDF+514/VQ3/nGA=;
        b=T9zWgj6YePtRuUXoy0hDcNS4O5zTTyLZNZg8fIdO2HzTCW16xauciP+ZZd9UveKojB
         wB2sxnHnpimYp02/vT0DfJYPkJGQz26W7hK9lrpGPDP9kVWJefFyiCFtXQ4lZYEPDURO
         skXL0O0cpF0Qb11DB3SUBqUdOzKhhi1rR09GzyWd43ZyCyaAPOBolPzyGByNGsgKA2ef
         yVzGpvwCBLR/OAknHQueD2j4Rbk8sJKEa5CqXW47XAVSkb9gW8zBKcjMewYGuLK9+HQq
         nOMY5nMi75XgDzt1RsZ55QDfr6HWGdn9ELn9IAwSy7+Jz1JVJAHXozvIK7GWVhA1s3Mb
         UH8Q==
X-Gm-Message-State: AOJu0YyBL08bVubUHWbqqcxS0VzkQr4ARaXbJBY+8yndqTCUQHVh2Y3x
	AFF6FqRiTkCde/nbDaQ5yQrNX+pxbvQ4viymKKo/t5TRHZ3i2rqqhWn+YbxdPZ47UdVGVPVGJ5C
	NRliwmXY5rlBc2ReAJT+Xpa2k
X-Received: by 2002:a17:906:10dc:b0:9a5:9038:b1e1 with SMTP id v28-20020a17090610dc00b009a59038b1e1mr3985438ejv.2.1693482072714;
        Thu, 31 Aug 2023 04:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5VY1nG5gFbZ/71OW0mNruZkepMA+ngQpuZnkU3OIgnWU2Inj+E0lnl6YIKRYaw2Zy6nAtwA==
X-Received: by 2002:a17:906:10dc:b0:9a5:9038:b1e1 with SMTP id v28-20020a17090610dc00b009a59038b1e1mr3985424ejv.2.1693482072370;
        Thu, 31 Aug 2023 04:41:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-255-219.dyn.eolo.it. [146.241.255.219])
        by smtp.gmail.com with ESMTPSA id p19-20020a17090635d300b0099c971ba285sm665123ejb.5.2023.08.31.04.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:41:11 -0700 (PDT)
Message-ID: <b2dcff0db691a9b358c4f89cf7a5b65a5a7dc4c5.camel@redhat.com>
Subject: Re: [PATCH] igb: disable virtualization features on 82580
From: Paolo Abeni <pabeni@redhat.com>
To: Corinna Vinschen <vinschen@redhat.com>, Tony Nguyen
	 <anthony.l.nguyen@intel.com>, jesse.brandeburg@intel.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Date: Thu, 31 Aug 2023 13:41:10 +0200
In-Reply-To: <20230831080916.588043-1-vinschen@redhat.com>
References: <20230831080916.588043-1-vinschen@redhat.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-31 at 10:09 +0200, Corinna Vinschen wrote:
> Disable virtualization features on 82580 just as on i210/i211.
> This avoids that virt functions are acidentally called on 82850.
>=20
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>

This looks like a fix to me?!? if so a suitable 'Fixes' tag should be
included.

Thanks!

Paolo


