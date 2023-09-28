Return-Path: <netdev+bounces-36735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D229D7B184D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D7CC9B20A84
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6042D290E;
	Thu, 28 Sep 2023 10:33:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5881C27
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 10:33:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0969C122
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695897193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xV0R5SFMvS2ZVoPQYyT8pFrz9wk+csz0/k3+o9zh82Q=;
	b=imvF42guhciYSlUftvJYR7PAd0FjvTv5ic5pppQx4YJWImhF1znk15su6R9pjrXc3loJxL
	dw+6ujzhGH/qHcC/DroUd3XkRxlnkoA6I28T5sgLF8aRKa7KIwt7kLdIVA7JvKF84MfLOB
	I7QQDsZ+txBCPZSxkTbSYW6vxbeRfSQ=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-RG1kaMuhNhSwj9XM7QQnZw-1; Thu, 28 Sep 2023 06:33:11 -0400
X-MC-Unique: RG1kaMuhNhSwj9XM7QQnZw-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-49ab22f0e07so199899e0c.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695897191; x=1696501991;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xV0R5SFMvS2ZVoPQYyT8pFrz9wk+csz0/k3+o9zh82Q=;
        b=eS/+1S30zMDJy6r+wTP3+Qcc88UCujcmnBT70+temVJyZBBqmHkEUEnqEkrNgZ28gP
         het7ikoLRka0FdWsazcQ8Ln0EHXbPe6H1SYXmUfUEL0/fDPPm99LHvyeJEFSc6+Smsp/
         h4OtY81NMyYspsfmgqJlAlZDO1IigOO3bL4NltqI4fXkPq+9TnXxlkInZ1egyUxxHbu2
         LM0S71kHY4bJM9gZG00ykRxHwTiXb9g+Oi/Q1yaJAekdORMTXR+KCDJPBmTjwP319g0+
         6tWMdaHmAvAS9kwJnkbpIJ8OMNW4bOJgkZMvWJnb1SKF/bX2qZU8e6VMmGx2Trek/VtO
         1xhw==
X-Gm-Message-State: AOJu0Yy8UMhIRP6Knq5frKIHQ0OJojMQa8Wc/ti4l/vYIhaJMz341yr5
	beE8JkjG1znzb1X6KIsx2ksIqe4/6yTkTJ5IrUD+bhSJI51dEwZSmMQsYKQIJJ7OsxE7/2ocr0B
	Fv+1nH4qZHpudfoCn
X-Received: by 2002:a05:6122:36a6:b0:493:5938:c8a1 with SMTP id ec38-20020a05612236a600b004935938c8a1mr310250vkb.0.1695897191291;
        Thu, 28 Sep 2023 03:33:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjrP8S7WYTplZaxjRLlrLON7meM0ludEGFSEkAKJ7AQUs7g8AMLCUUxWGOKhqlkPfB4hAxRQ==
X-Received: by 2002:a05:6122:36a6:b0:493:5938:c8a1 with SMTP id ec38-20020a05612236a600b004935938c8a1mr310242vkb.0.1695897190960;
        Thu, 28 Sep 2023 03:33:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-183.dyn.eolo.it. [146.241.233.183])
        by smtp.gmail.com with ESMTPSA id r1-20020a0c9e81000000b00656e2464719sm1374297qvd.92.2023.09.28.03.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 03:33:10 -0700 (PDT)
Message-ID: <7b83b400cff5ecb7e150e4c0a4bca861ff08b392.camel@redhat.com>
Subject: Re: [net-next PATCH v3 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
From: Paolo Abeni <pabeni@redhat.com>
To: Amritha Nambiar <amritha.nambiar@intel.com>, netdev@vger.kernel.org, 
	kuba@kernel.org
Cc: sridhar.samudrala@intel.com
Date: Thu, 28 Sep 2023 12:33:08 +0200
In-Reply-To: <169516244040.7377.16515332696427625794.stgit@anambiarhost.jf.intel.com>
References: 
	<169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
	 <169516244040.7377.16515332696427625794.stgit@anambiarhost.jf.intel.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-19 at 15:27 -0700, Amritha Nambiar wrote:
> Add support in netlink spec(netdev.yaml) for queue information.
> Add code generated from the spec.
>=20
> Note: The "q-type" attribute currently takes values 0 and 1 for rx
> and tx queue type respectively. I haven't figured out the ynl
> library changes to support string user input ("rx" and "tx") to
> enum value conversion in the generated file.
>=20
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  Documentation/netlink/specs/netdev.yaml |   52 ++++++++++
>  include/uapi/linux/netdev.h             |   17 +++
>  net/core/netdev-genl-gen.c              |   26 +++++
>  net/core/netdev-genl-gen.h              |    3 +
>  net/core/netdev-genl.c                  |   10 ++
>  tools/include/uapi/linux/netdev.h       |   17 +++
>  tools/net/ynl/generated/netdev-user.c   |  159 +++++++++++++++++++++++++=
++++++
>  tools/net/ynl/generated/netdev-user.h   |  101 ++++++++++++++++++++
>  8 files changed, 385 insertions(+)
>=20
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index c46fcc78fc04..7b5d4cdff48b 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -55,6 +55,10 @@ definitions:
>          name: hash
>          doc:
>            Device is capable of exposing receive packet hash via bpf_xdp_=
metadata_rx_hash().
> +  -
> +    name: queue-type
> +    type: enum
> +    entries: [ rx, tx ]
> =20
>  attribute-sets:
>    -
> @@ -89,6 +93,32 @@ attribute-sets:
>          enum: xdp-rx-metadata
>          enum-as-flags: true
> =20
> +  -
> +    name: queue
> +    attributes:
> +      -
> +        name: q-id

Why not 'queue-id' or 'id'?

> +        doc: queue index
> +        type: u32
> +      -
> +        name: ifindex
> +        doc: netdev ifindex
> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: q-type

Same here?



Cheers,

Paolo


