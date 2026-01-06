Return-Path: <netdev+bounces-247319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C390CF7452
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 09:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D1C331679DD
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B66930B510;
	Tue,  6 Jan 2026 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OGCxL/zC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950E12BD597
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767687340; cv=none; b=Ku6uVTGWL7UV0NYJnKQhz4yAj+PqO2J+oGnvqQ6hMQH7wQXzVAhnNPQq8hh9MHwW2vFB646ldEKgVGrhs7d/XBBNWa3hPUXKLMwjP6U2neLVcaItyDFREoNhSh03GFwZ5sTGIP+P7rg1K0B8IsouS58wzPlAuO8/wlKMywXDXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767687340; c=relaxed/simple;
	bh=bK+on8TJIaxpQw5KhTYv6zv2X4jFiFzm1emI+L7tk38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxFXPy5nDViSYo56wfhBgS9Io9TXUayb5hYvGszYAdBsTbwoatijSZ8tBUnJMDbO6k6v6Ul7Ig6Z9U6AHeMzgW+QmCdc43flMU02IT5ZSkM0QlvsgBvH6j5zZe9uNFjxgpK9+Ox67NpKfCeXRD5+E3pa8dmGf7fUGw2sM47yvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OGCxL/zC; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-790abc54b24so2963477b3.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 00:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767687335; x=1768292135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JkpQ6CTNJ2FIvRZXQ6kOQTWeuUWh+NTfLwdyhqwtI8=;
        b=nIvRX8Z8bAu/8tQw4RQPJdCwbZocyAOYF9upBi5MdsooiYJVy6VdVl5U37t4HPAPrk
         AEJ7fDfEauZvSE4boh/VZJhLlsFUKHHd+5YOj8fy8iuSD6yMPsuebF5rYMZVUjNicDie
         ozfK+D+zH5YXDdY4nnm6cKPyWZZzPMCkZIgVndq92R9s1iW/CHRiPpoWem00AjMf0co5
         BNxsrjHuVlz8HkxVDsx4Nyp7mKfWNAXveNKTNBsPX8Jr+ovnjY8zJMiTfbqkc0eNfJpT
         61IoWJ5N+VPvkM/JRzcwrAMhTUvSYQa0LoiAypfiCmKM+6HEiNdhnDEiOJI0bWvBoLaV
         P13A==
X-Gm-Message-State: AOJu0Yx/9d4CpqSEl4yqPurb3vfl7+J3s9+dppjCIu5QwVi/mTrl4zDD
	da2LkZBdZUp2rA93BF2kZQZdHWlGK4nF3qU88MJEMta/P2IAGJvr3xBzPvF8M8iqDd3HpkLStro
	K3PuAB8Pf1CGIxRLMdKMmStd/vm608ySdqrDPXeH/cajTti3vqSJ8WWx2wgbMc9Z7VnfPmxtPEU
	megWc5yBX1JoewKInsezhauH4jMFYiu9mrdpF2asJhOpcENnqvZXtYTJaMGi+sBfuv8ESOEseiF
	JGT7rYYGzVuSJuZU1cBKVZU
X-Gm-Gg: AY/fxX6EB7GbhMpdeTQ4czejwQU0jzqN+QjK97WwTR4WPWgH58tx97shdRZ13hS8opr
	QPqoXmXWHTzIZqSlqmqaSY6cVDc21E7K/MWBshdrm9BtZN9jjuHG5WTkSmWAOqUHOLz177yDi4U
	S8JV9eiK9RnRCT9Y/nly9le4ZkalKa7vh+fDAvKE21wbseZ/Ixm7IPADBr7OTjafN8NwIZAD+5T
	+kAOeoY5A8Qe50xhrVJwTVlOCVOqHLLFR19DDEBnNneETWgBOiKj8q39B+4JSX6Df5Xbed/Zziz
	voURydmIyEmVRxiTohYatdKdUhJ/iC5e9ZJsAoE5T99LeCNMfl7lGRRFM6bK/BkGPYp/CYJoySV
	8raegyreDOu+dxjYJhdK43pVaTNsWa0qk761WnHKRWeco3mrc+CTIzZW1oJXqH6m0lTELim6AOr
	u8rUtLbmRExq9NaljRM9a1G/vWo7T3/Tirnw2mQlgO7VZx3QCfkfaN/yE=
X-Google-Smtp-Source: AGHT+IFhKJzVCNWr5uY5lJOtecy0ZraVa8JD4XHHyZCHGv4MZJ5agby4EdkElNR2SwThtRpX1ASLmmQe23h2
X-Received: by 2002:a05:690e:b8e:b0:646:6f6f:a2e with SMTP id 956f58d0204a3-6470c8418d9mr1453643d50.9.1767687335222;
        Tue, 06 Jan 2026 00:15:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6470d81bb3bsm154557d50.6.2026.01.06.00.15.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jan 2026 00:15:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34a9bb41009so1492207a91.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 00:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767687333; x=1768292133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7JkpQ6CTNJ2FIvRZXQ6kOQTWeuUWh+NTfLwdyhqwtI8=;
        b=OGCxL/zCrEPnl/kWBXRhyZ07Ew9uC5WaWL9L1EzNWTYcQnmhkE3R2FMWFH11lQDbP+
         JUIdA1CiMSkCwu8Wt/zm0bQslx2b3q2H4t9fgn0A90+e+c/RD7Svz5me5luP1vC0KNA3
         lvRWONWJgZ3kx2yeSz5K7Zlm45EcxQ2OvYWiQ=
X-Received: by 2002:a17:90b:558c:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-34f5f271f98mr1666767a91.13.1767687332777;
        Tue, 06 Jan 2026 00:15:32 -0800 (PST)
X-Received: by 2002:a17:90b:558c:b0:32e:a5ae:d00 with SMTP id
 98e67ed59e1d1-34f5f271f98mr1666739a91.13.1767687331986; Tue, 06 Jan 2026
 00:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105023254.1426488-1-rkannoth@marvell.com> <20260105023254.1426488-2-rkannoth@marvell.com>
In-Reply-To: <20260105023254.1426488-2-rkannoth@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 6 Jan 2026 13:45:21 +0530
X-Gm-Features: AQt7F2oaBkK5xLAkaYpeuEodgo-LHFUMw7fghXzQPAU7Rc85x-37zXSKHgLF9k0
Message-ID: <CAH-L+nMPAUAfwvKeejPrQxN6hwKc0gMYmnVYfZW8KeqC6YMR3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 01/13] octeontx2-af: npc: cn20k: Index management
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sgoutham@marvell.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, sumang@marvell.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000099dd970647b3c77a"

--00000000000099dd970647b3c77a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 8:04=E2=80=AFAM Ratheesh Kannoth <rkannoth@marvell.c=
om> wrote:
>
> In CN20K silicon, the MCAM is divided vertically into two banks.
> Each bank has a depth of 8192.
>
> The MCAM is divided horizontally into 32 subbanks, with each subbank
> having a depth of 256.
>
> Each subbank can accommodate either x2 keys or x4 keys. x2 keys are
> 256 bits in size, and x4 keys are 512 bits in size.
>
>     Bank1                   Bank0
>     |-----------------------------|
>     |               |             | subbank 31 { depth 256 }
>     |               |             |
>     |-----------------------------|
>     |               |             | subbank 30
>     |               |             |
>     ------------------------------
>     ...............................
>
>     |-----------------------------|
>     |               |             | subbank 0
>     |               |             |
>     ------------------------------|
>
> This patch implements the following allocation schemes in NPC.
> The allocation API accepts reference (ref), limit, contig, priority,
> and count values. For example, specifying ref=3D100, limit=3D200,
> contig=3D1, priority=3DLOW, and count=3D20 will allocate 20 contiguous
> MCAM entries between entries 100 and 200.
>
> 1. Contiguous allocation with ref, limit, and priority.
> 2. Non-contiguous allocation with ref, limit, and priority.
> 3. Non-contiguous allocation without ref.
> 4. Contiguous allocation without ref.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  MAINTAINERS                                   |    2 +-
>  .../ethernet/marvell/octeontx2/af/Makefile    |    2 +-
>  .../marvell/octeontx2/af/cn20k/debugfs.c      |  182 ++
>  .../marvell/octeontx2/af/cn20k/debugfs.h      |    3 +
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 1798 +++++++++++++++++
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   65 +
>  .../ethernet/marvell/octeontx2/af/cn20k/reg.h |    3 +
>  .../ethernet/marvell/octeontx2/af/common.h    |    4 -
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   18 +
>  .../marvell/octeontx2/af/rvu_debugfs.c        |    3 +
>  .../ethernet/marvell/octeontx2/af/rvu_npc.c   |    8 +-
>  11 files changed, 2081 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 454b8ed119e9..0111506e8fe4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15304,7 +15304,7 @@ M:      Subbaraya Sundeep <sbhatta@marvell.com>
>  L:     netdev@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/networking/device_drivers/ethernet/marvell/octeontx=
2.rst
> -F:     drivers/net/ethernet/marvell/octeontx2/af/
> +F:     drivers/net/ethernet/marvell/octeontx2/af/*
>
>  MARVELL PEM PMU DRIVER
>  M:     Linu Cherian <lcherian@marvell.com>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers=
/net/ethernet/marvell/octeontx2/af/Makefile
> index 244de500963e..91b7d6e96a61 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> @@ -13,4 +13,4 @@ rvu_af-y :=3D cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o=
 \
>                   rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o =
\
>                   rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb=
.o \
>                   rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o=
 \
> -                 cn20k/npa.o
> +                 cn20k/npa.o cn20k/npc.o
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/=
drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> index 498968bf4cf5..c7c59a98d969 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> @@ -11,7 +11,189 @@
>  #include <linux/pci.h>
>
>  #include "struct.h"
> +#include "rvu.h"
>  #include "debugfs.h"
> +#include "cn20k/npc.h"
> +
> +static void npc_subbank_srch_order_dbgfs_usage(void)
> +{
> +       pr_err("Usage: echo \"[0]=3D[8],[1]=3D7,[2]=3D30,...[31]=3D0\" > =
<debugfs>/subbank_srch_order\n");
> +}
> +
> +static int
> +npc_subbank_srch_order_parse_n_fill(struct rvu *rvu, char *options,
> +                                   int num_subbanks)
> +{
> +       unsigned long w1 =3D 0, w2 =3D 0;
> +       char *p, *t1, *t2;
> +       int (*arr)[2];
> +       int idx, val;
> +       int cnt, ret;
> +
> +       cnt =3D 0;
> +
> +       options[strcspn(options, "\r\n")] =3D 0;
> +
> +       arr =3D kcalloc(num_subbanks, sizeof(*arr), GFP_KERNEL);
> +       if (!arr)
> +               return -ENOMEM;
> +
> +       while ((p =3D strsep(&options, " ,")) !=3D NULL) {
> +               if (!*p)
> +                       continue;
> +
> +               t1 =3D strsep(&p, "=3D");
> +               t2 =3D strsep(&p, "");
> +
> +               if (strlen(t1) < 3) {
> +                       pr_err("%s:%d Bad Token %s=3D%s\n",
> +                              __func__, __LINE__, t1, t2);
> +                       goto err;
> +               }
> +
> +               if (t1[0] !=3D '[' || t1[strlen(t1) - 1] !=3D ']') {
> +                       pr_err("%s:%d Bad Token %s=3D%s\n",
> +                              __func__, __LINE__, t1, t2);
> +                       goto err;
> +               }
> +
> +               t1[0] =3D ' ';
> +               t1[strlen(t1) - 1] =3D ' ';
> +               t1 =3D strim(t1);
> +
> +               ret =3D kstrtoint(t1, 10, &idx);
> +               if (ret) {
> +                       pr_err("%s:%d Bad Token %s=3D%s\n",
> +                              __func__, __LINE__, t1, t2);
> +                       goto err;
> +               }
> +
> +               ret =3D kstrtoint(t2, 10, &val);
> +               if (ret) {
> +                       pr_err("%s:%d Bad Token %s=3D%s\n",
> +                              __func__, __LINE__, t1, t2);
> +                       goto err;
> +               }
> +
> +               (*(arr + cnt))[0] =3D idx;
> +               (*(arr + cnt))[1] =3D val;
> +
> +               cnt++;
> +       }
> +
> +       if (cnt !=3D num_subbanks) {
> +               pr_err("Could find %u tokens, but exact %u tokens needed\=
n",
> +                      cnt, num_subbanks);
> +               goto err;
> +       }
> +
> +       for (int i =3D 0; i < cnt; i++) {
> +               w1 |=3D BIT_ULL((*(arr + i))[0]);
> +               w2 |=3D BIT_ULL((*(arr + i))[1]);
> +       }
> +
> +       if (bitmap_weight(&w1, cnt) !=3D cnt) {
> +               pr_err("Missed to fill for [%lu]=3D\n",
> +                      find_first_zero_bit(&w1, cnt));
> +               goto err;
> +       }
> +
> +       if (bitmap_weight(&w2, cnt) !=3D cnt) {
> +               pr_err("Missed to fill value %lu\n",
> +                      find_first_zero_bit(&w2, cnt));
> +               goto err;
> +       }
> +
> +       npc_cn20k_search_order_set(rvu, arr, cnt);
> +
> +       kfree(arr);
> +       return 0;
> +err:
> +       kfree(arr);
> +       return -EINVAL;
> +}
> +
> +static ssize_t
> +npc_subbank_srch_order_write(struct file *file, const char __user *user_=
buf,
> +                            size_t count, loff_t *ppos)
> +{
> +       struct npc_priv_t *npc_priv;
> +       struct rvu *rvu;
> +       char buf[1024];
> +       int len;
> +
> +       npc_priv =3D npc_priv_get();
> +
> +       rvu =3D file->private_data;
> +
> +       len =3D simple_write_to_buffer(buf, sizeof(buf), ppos,
> +                                    user_buf, count);
> +       if (npc_subbank_srch_order_parse_n_fill(rvu, buf,
> +                                               npc_priv->num_subbanks)) =
{
> +               npc_subbank_srch_order_dbgfs_usage();
> +               return -EFAULT;
> +       }
> +
> +       return len;
> +}
> +
> +static ssize_t
> +npc_subbank_srch_order_read(struct file *file, char __user *user_buf,
> +                           size_t count, loff_t *ppos)
> +{
> +       struct npc_priv_t *npc_priv;
> +       bool restricted_order;
> +       const int *srch_order;
> +       char buf[1024];
> +       int len =3D 0;
> +
> +       npc_priv =3D npc_priv_get();
> +
> +       len +=3D snprintf(buf + len, sizeof(buf) - len, "%s",
> +                       "Usage: echo \"[0]=3D0,[1]=3D1,[2]=3D2,..[31]=3D3=
1\" > <debugfs>/subbank_srch_order\n");
> +
> +       len +=3D snprintf(buf + len, sizeof(buf) - len, "%s",
> +                       "Search order\n");
> +
> +       srch_order =3D npc_cn20k_search_order_get(&restricted_order);
> +
> +       for (int i =3D 0;  i < npc_priv->num_subbanks; i++)
> +               len +=3D snprintf(buf + len, sizeof(buf) - len, "[%d]=3D%=
d,",
> +                               i, srch_order[i]);
> +
> +       len +=3D snprintf(buf + len - 1, sizeof(buf) - len, "%s", "\n");
> +
> +       if (restricted_order)
> +               len +=3D snprintf(buf + len, sizeof(buf) - len,
> +                               "Restricted allocation for subbanks %u, %=
u\n",
> +                               npc_priv->num_subbanks - 1, 0);
> +
> +       return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +}
> +
> +static const struct file_operations npc_subbank_srch_order_ops =3D {
> +       .open           =3D simple_open,
> +       .write          =3D npc_subbank_srch_order_write,
> +       .read           =3D npc_subbank_srch_order_read,
> +};
> +
> +int npc_cn20k_debugfs_init(struct rvu *rvu)
> +{
> +       struct dentry *npc_dentry;
> +
> +       npc_dentry =3D debugfs_create_file("subbank_srch_order", 0644,
> +                                        rvu->rvu_dbg.npc,
> +                                        rvu, &npc_subbank_srch_order_ops=
);
> +       if (!npc_dentry)
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +void npc_cn20k_debugfs_deinit(struct rvu *rvu)
> +{
> +       debugfs_remove_recursive(rvu->rvu_dbg.npc);
> +}
>
>  void print_nix_cn20k_sq_ctx(struct seq_file *m,
>                             struct nix_cn20k_sq_ctx_s *sq_ctx)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h b/=
drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
> index a2e3a2cd6edb..0c5f05883666 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
> @@ -16,6 +16,9 @@
>  #include "struct.h"
>  #include "../mbox.h"
>
> +int npc_cn20k_debugfs_init(struct rvu *rvu);
> +void npc_cn20k_debugfs_deinit(struct rvu *rvu);
> +
>  void print_nix_cn20k_sq_ctx(struct seq_file *m,
>                             struct nix_cn20k_sq_ctx_s *sq_ctx);
>  void print_nix_cn20k_cq_ctx(struct seq_file *m,
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> new file mode 100644
> index 000000000000..27b049ac4ae8
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -0,0 +1,1798 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell RVU Admin Function driver
> + *
> + * Copyright (C) 2026 Marvell.
> + *
> + */
> +#include <linux/xarray.h>
> +#include <linux/bitfield.h>
> +
> +#include "cn20k/npc.h"
> +#include "cn20k/reg.h"
> +
> +static struct npc_priv_t npc_priv =3D {
> +       .num_banks =3D MAX_NUM_BANKS,
> +};
> +
> +static const char *npc_kw_name[NPC_MCAM_KEY_MAX] =3D {
> +       [NPC_MCAM_KEY_DYN] =3D "DYNAMIC",
> +       [NPC_MCAM_KEY_X2] =3D "X2",
> +       [NPC_MCAM_KEY_X4] =3D "X4",
> +};
> +
> +struct npc_priv_t *npc_priv_get(void)
> +{
> +       return &npc_priv;
> +}
> +
> +static int npc_subbank_idx_2_mcam_idx(struct rvu *rvu, struct npc_subban=
k *sb,
> +                                     u16 sub_off, u16 *mcam_idx)
> +{
> +       int off, bot;
> +
> +       /* for x4 section, maximum allowed subbank index =3D
> +        * subsection depth - 1
> +        */
> +       if (sb->key_type =3D=3D NPC_MCAM_KEY_X4 &&
> +           sub_off >=3D npc_priv.subbank_depth) {
> +               dev_err(rvu->dev, "%s:%d bad params\n",
> +                       __func__, __LINE__);
> +               return -EINVAL;
> +       }
> +
> +       /* for x2 section, maximum allowed subbank index =3D
> +        * 2 * subsection depth - 1
> +        */
> +       if (sb->key_type =3D=3D NPC_MCAM_KEY_X2 &&
> +           sub_off >=3D npc_priv.subbank_depth * 2) {
> +               dev_err(rvu->dev, "%s:%d bad params\n",
> +                       __func__, __LINE__);
> +               return -EINVAL;
> +       }
> +
> +       /* Find subbank offset from respective subbank (w.r.t bank) */
> +       off =3D sub_off & (npc_priv.subbank_depth - 1);
> +
> +       /* if subsection idx is in bank1, add bank depth,
> +        * which is part of sb->b1b
> +        */
> +       bot =3D sub_off >=3D npc_priv.subbank_depth ? sb->b1b : sb->b0b;
> +
> +       *mcam_idx =3D bot + off;
> +       return 0;
> +}
> +
> +static int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
> +                                     struct npc_subbank **sb,
> +                                     int *sb_off)
> +{
> +       int bank_off, sb_id;
> +
> +       /* mcam_idx should be less than (2 * bank depth) */
> +       if (mcam_idx >=3D npc_priv.bank_depth * 2) {
> +               dev_err(rvu->dev, "%s:%d bad params\n",
> +                       __func__, __LINE__);
> +               return -EINVAL;
> +       }
> +
> +       /* find mcam offset per bank */
> +       bank_off =3D mcam_idx & (npc_priv.bank_depth - 1);
> +
> +       /* Find subbank id */
> +       sb_id =3D bank_off / npc_priv.subbank_depth;
> +
> +       /* Check if subbank id is more than maximum
> +        * number of subbanks available
> +        */
> +       if (sb_id >=3D npc_priv.num_subbanks) {
> +               dev_err(rvu->dev, "%s:%d invalid subbank %d\n",
> +                       __func__, __LINE__, sb_id);
> +               return -EINVAL;
> +       }
> +
> +       *sb =3D &npc_priv.sb[sb_id];
> +
> +       /* Subbank offset per bank */
> +       *sb_off =3D bank_off % npc_priv.subbank_depth;
> +
> +       /* Index in a subbank should add subbank depth
> +        * if it is in bank1
> +        */
> +       if (mcam_idx >=3D npc_priv.bank_depth)
> +               *sb_off +=3D npc_priv.subbank_depth;
> +
> +       return 0;
> +}
> +
> +static int __npc_subbank_contig_alloc(struct rvu *rvu,
> +                                     struct npc_subbank *sb,
> +                                     int key_type, int sidx,
> +                                     int eidx, int prio,
> +                                     int count, int t, int b,
> +                                     unsigned long *bmap,
> +                                     u16 *save)
> +{
> +       int k, offset, delta =3D 0;
> +       int cnt =3D 0, sbd;
> +
> +       sbd =3D npc_priv.subbank_depth;
> +
> +       if (sidx >=3D npc_priv.bank_depth)
> +               delta =3D sbd;
> +
> +       switch (prio) {
> +       case NPC_MCAM_LOWER_PRIO:
> +       case NPC_MCAM_ANY_PRIO:
> +               /* Find an area of size 'count' from sidx to eidx */
> +               offset =3D bitmap_find_next_zero_area(bmap, sbd, sidx - b=
,
> +                                                   count, 0);
> +
> +               if (offset >=3D sbd) {
> +                       dev_err(rvu->dev,
> +                               "%s:%d Could not find contiguous(%d) entr=
ies\n",
> +                               __func__, __LINE__, count);
> +                       return -EFAULT;
> +               }
> +
> +               dev_dbg(rvu->dev,
> +                       "%s:%d sidx=3D%d eidx=3D%d t=3D%d b=3D%d offset=
=3D%d count=3D%d delta=3D%d\n",
> +                       __func__, __LINE__, sidx, eidx, t, b, offset,
> +                       count, delta);
> +
> +               for (cnt =3D 0; cnt < count; cnt++)
> +                       save[cnt] =3D offset + cnt + delta;
> +
> +               break;
> +
> +       case NPC_MCAM_HIGHER_PRIO:
> +               /* Find an area of 'count' from eidx to sidx */
> +               for (k =3D eidx - b; cnt < count && k >=3D (sidx - b); k-=
-) {
> +                       /* If an intermediate slot is not free,
> +                        * reset the counter (cnt) to zero as
> +                        * request is for contiguous.
> +                        */
> +                       if (test_bit(k, bmap)) {
> +                               cnt =3D 0;
> +                               continue;
> +                       }
> +
> +                       save[cnt++] =3D k + delta;
> +               }
> +               break;
> +       }
> +
> +       /* Found 'count' number of free slots */
> +       if (cnt =3D=3D count)
> +               return 0;
> +
> +       dev_dbg(rvu->dev,
> +               "%s:%d Could not find contiguous(%d) entries in subbbank=
=3D%u\n",
> +               __func__, __LINE__, count, sb->idx);
> +       return -EFAULT;
> +}
> +
> +static int __npc_subbank_non_contig_alloc(struct rvu *rvu,
> +                                         struct npc_subbank *sb,
> +                                         int key_type, int sidx,
> +                                         int eidx, int prio,
> +                                         int t, int b,
> +                                         unsigned long *bmap,
> +                                         int count, u16 *save,
> +                                         bool max_alloc, int *alloc_cnt)
> +{
> +       unsigned long index;
> +       int cnt =3D 0, delta;
> +       int k, sbd;
> +
> +       sbd =3D npc_priv.subbank_depth;
> +       delta =3D sidx >=3D npc_priv.bank_depth ? sbd : 0;
> +
> +       switch (prio) {
> +               /* Find an area of size 'count' from sidx to eidx */
> +       case NPC_MCAM_LOWER_PRIO:
> +       case NPC_MCAM_ANY_PRIO:
> +               index =3D find_next_zero_bit(bmap, sbd, sidx - b);
> +               if (index >=3D sbd) {
> +                       dev_err(rvu->dev,
> +                               "%s:%d Error happened to alloc %u, bitmap=
_weight=3D%u, sb->idx=3D%u\n",
> +                               __func__, __LINE__, count,
> +                               bitmap_weight(bmap, sbd),
> +                               sb->idx);
> +                       break;
> +               }
> +
> +               for (k =3D index; cnt < count && k <=3D (eidx - b); k++) =
{
> +                       /* Skip used slots */
> +                       if (test_bit(k, bmap))
> +                               continue;
> +
> +                       save[cnt++] =3D k + delta;
> +               }
> +               break;
> +
> +               /* Find an area of 'count' from eidx to sidx */
> +       case NPC_MCAM_HIGHER_PRIO:
> +               for (k =3D eidx - b; cnt < count && k >=3D (sidx - b); k-=
-) {
> +                       /* Skip used slots */
> +                       if (test_bit(k, bmap))
> +                               continue;
> +
> +                       save[cnt++] =3D k + delta;
> +               }
> +               break;
> +       }
> +
> +       /* Update allocated 'cnt' to alloc_cnt */
> +       *alloc_cnt =3D cnt;
> +
> +       /* Successfully allocated requested count slots */
> +       if (cnt =3D=3D count)
> +               return 0;
> +
> +       /* Allocation successful for cnt < count */
> +       if (max_alloc && cnt > 0)
> +               return 0;
> +
> +       dev_dbg(rvu->dev,
> +               "%s:%d Could not find non contiguous entries(%u) in subba=
nk(%u) cnt=3D%d max_alloc=3D%d\n",
> +               __func__, __LINE__, count, sb->idx, cnt, max_alloc);
> +
> +       return -EFAULT;
> +}
> +
> +static void __npc_subbank_sboff_2_off(struct rvu *rvu, struct npc_subban=
k *sb,
> +                                     int sb_off, unsigned long **bmap,
> +                                     int *off)
> +{
> +       int sbd;
> +
> +       sbd =3D npc_priv.subbank_depth;
> +
> +       *off =3D sb_off & (sbd - 1);
> +       *bmap =3D (sb_off >=3D sbd) ? sb->b1map : sb->b0map;
> +}
> +
> +/* set/clear bitmap */
> +static bool __npc_subbank_mark_slot(struct rvu *rvu,
> +                                   struct npc_subbank *sb,
> +                                   int sb_off, bool set)
> +{
> +       unsigned long *bmap;
> +       int off;
> +
> +       /* if sb_off >=3D subbank.depth, then slots are in
> +        * bank1
> +        */
> +       __npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
> +
> +       dev_dbg(rvu->dev,
> +               "%s:%d Marking set=3D%d sb_off=3D%d sb->idx=3D%d off=3D%d=
\n",
> +               __func__, __LINE__, set, sb_off, sb->idx, off);
> +
> +       if (set) {
> +               /* Slot is already used */
> +               if (test_bit(off, bmap))
> +                       return false;
> +
> +               sb->free_cnt--;
> +               set_bit(off, bmap);
> +               return true;
> +       }
> +
> +       /* Slot is already free */
> +       if (!test_bit(off, bmap))
> +               return false;
> +
> +       sb->free_cnt++;
> +       clear_bit(off, bmap);
> +       return true;
> +}
> +
> +static int __npc_subbank_mark_free(struct rvu *rvu, struct npc_subbank *=
sb)
> +{
> +       int rc, blkaddr;
> +       void *val;
> +
> +       sb->flags =3D NPC_SUBBANK_FLAG_FREE;
> +       sb->key_type =3D 0;
> +
> +       bitmap_clear(sb->b0map, 0, npc_priv.subbank_depth);
> +       bitmap_clear(sb->b1map, 0, npc_priv.subbank_depth);
> +
> +       if (!xa_erase(&npc_priv.xa_sb_used, sb->arr_idx)) {
> +               dev_err(rvu->dev, "%s:%d Error to delete from xa_sb_used =
array\n",
> +                       __func__, __LINE__);
> +               return -EFAULT;
> +       }
> +
> +       rc =3D xa_insert(&npc_priv.xa_sb_free, sb->arr_idx,
> +                      xa_mk_value(sb->idx), GFP_KERNEL);
> +       if (rc) {
> +               val =3D xa_load(&npc_priv.xa_sb_free, sb->arr_idx);
> +               dev_err(rvu->dev,
> +                       "%s:%d Error to add sb(%u) to xa_sb_free array at=
 arr_idx=3D%d, val=3D%lu\n",
> +                       __func__, __LINE__,
> +                       sb->idx, sb->arr_idx, xa_to_value(val));
> +       }
> +
> +       blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +       rvu_write64(rvu, blkaddr,
> +                   NPC_AF_MCAM_SECTIONX_CFG_EXT(sb->idx),
> +                   NPC_MCAM_KEY_X2);
> +
> +       return rc;
> +}
> +
> +static int __npc_subbank_mark_used(struct rvu *rvu, struct npc_subbank *=
sb,
> +                                  int key_type)
> +
> +{
> +       int rc;
> +
> +       sb->flags =3D NPC_SUBBANK_FLAG_USED;
> +       sb->key_type =3D key_type;
> +       if (key_type =3D=3D NPC_MCAM_KEY_X4)
> +               sb->free_cnt =3D npc_priv.subbank_depth;
> +       else
> +               sb->free_cnt =3D 2 * npc_priv.subbank_depth;
> +
> +       bitmap_clear(sb->b0map, 0, npc_priv.subbank_depth);
> +       bitmap_clear(sb->b1map, 0, npc_priv.subbank_depth);
> +
> +       if (!xa_erase(&npc_priv.xa_sb_free, sb->arr_idx)) {
> +               dev_err(rvu->dev, "%s:%d Error to delete from xa_sb_free =
array\n",
> +                       __func__, __LINE__);
> +               return -EFAULT;
> +       }
> +
> +       rc =3D xa_insert(&npc_priv.xa_sb_used, sb->arr_idx,
> +                      xa_mk_value(sb->idx), GFP_KERNEL);
> +       if (rc)
> +               dev_err(rvu->dev, "%s:%d Error to add to xa_sb_used array=
\n",
> +                       __func__, __LINE__);
> +
> +       return rc;
> +}
> +
> +static bool __npc_subbank_free(struct rvu *rvu, struct npc_subbank *sb,
> +                              u16 sb_off)
> +{
> +       bool deleted =3D false;
> +       unsigned long *bmap;
> +       int rc, off;
> +
> +       deleted =3D __npc_subbank_mark_slot(rvu, sb, sb_off, false);
> +       if (!deleted)
> +               goto done;
> +
> +       __npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
> +
> +       /* Check whether we can mark whole subbank as free */
> +       if (sb->key_type =3D=3D NPC_MCAM_KEY_X4) {
> +               if (sb->free_cnt < npc_priv.subbank_depth)
> +                       goto done;
> +       } else {
> +               if (sb->free_cnt < 2 * npc_priv.subbank_depth)
> +                       goto done;
> +       }
> +
> +       /* All slots in subbank are unused. Mark the subbank as free
> +        * and add to free pool
> +        */
> +       rc =3D __npc_subbank_mark_free(rvu, sb);
> +       if (rc)
> +               dev_err(rvu->dev, "%s:%d Error to free subbank\n",
> +                       __func__, __LINE__);
> +
> +done:
> +       return deleted;
> +}
> +
> +static int __maybe_unused
> +npc_subbank_free(struct rvu *rvu, struct npc_subbank *sb, u16 sb_off)
> +{
> +       bool deleted;
> +
> +       mutex_lock(&sb->lock);
> +       deleted =3D __npc_subbank_free(rvu, sb, sb_off);
> +       mutex_unlock(&sb->lock);
> +
> +       return deleted ? 0 : -EFAULT;
> +}
> +
> +static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
> +                              int key_type, int ref, int limit, int prio=
,
> +                              bool contig, int count, u16 *mcam_idx,
> +                              int idx_sz, bool max_alloc, int *alloc_cnt=
)
> +{
> +       int cnt, t, b, i, blkaddr;
> +       bool new_sub_bank =3D false;
> +       unsigned long *bmap;
> +       u16 *save =3D NULL;
> +       int sidx, eidx;
> +       bool diffbank;
> +       int bw, bfree;
> +       int rc =3D 0;
> +       bool ret;
> +
> +       /* Check if enough space is there to return requested number of
> +        * mcam indexes in case of contiguous allocation
> +        */
> +       if (!max_alloc && count > idx_sz) {
> +               dev_err(rvu->dev,
> +                       "%s:%d Less space, count=3D%d idx_sz=3D%d sb_id=
=3D%d\n",
> +                       __func__, __LINE__, count, idx_sz, sb->idx);
> +               return -ENOSPC;
> +       }
> +
> +       /* Allocation on multiple subbank is not supported by this functi=
on.
> +        * it means that ref and limit should be on same subbank.
> +        *
> +        * ref and limit values should be validated w.r.t prio as below.
> +        * say ref =3D 100, limit =3D 200,
> +        * if NPC_MCAM_LOWER_PRIO, allocate index 100
> +        * if NPC_MCAM_HIGHER_PRIO, below sanity test returns error.
> +        * if NPC_MCAM_ANY_PRIO, allocate index 100
> +        *
> +        * say ref =3D 200, limit =3D 100
> +        * if NPC_MCAM_LOWER_PRIO, below sanity test returns error.
> +        * if NPC_MCAM_HIGHER_PRIO, allocate index 200
> +        * if NPC_MCAM_ANY_PRIO, allocate index 100
> +        *
> +        * Please note that NPC_MCAM_ANY_PRIO does not have any restricti=
on
> +        * on "ref" and "limit" values. ie, ref > limit and limit > ref
> +        * are valid cases.
> +        */
> +       if ((prio =3D=3D NPC_MCAM_LOWER_PRIO && ref > limit) ||
> +           (prio =3D=3D NPC_MCAM_HIGHER_PRIO && ref < limit)) {
> +               dev_err(rvu->dev, "%s:%d Wrong ref_enty(%d) or limit(%d)\=
n",
> +                       __func__, __LINE__, ref, limit);
> +               return -EINVAL;
> +       }
> +
> +       /* x4 indexes are from 0 to bank size as it combines two x2 banks=
 */
> +       if (key_type =3D=3D NPC_MCAM_KEY_X4 &&
> +           (ref >=3D npc_priv.bank_depth || limit >=3D npc_priv.bank_dep=
th)) {
> +               dev_err(rvu->dev, "%s:%d Wrong ref_enty(%d) or limit(%d) =
for x4\n",
> +                       __func__, __LINE__, ref, limit);
> +               return -EINVAL;
> +       }
> +
> +       /* This function is called either bank0 or bank1 portion of a sub=
bank.
> +        * so ref and limit should be on same bank.
> +        */
> +       diffbank =3D !!((ref & npc_priv.bank_depth) ^
> +                     (limit & npc_priv.bank_depth));
> +       if (diffbank) {
> +               dev_err(rvu->dev, "%s:%d request ref and limit should be =
from same bank\n",
> +                       __func__, __LINE__);
> +               return -EINVAL;
> +       }
> +
> +       sidx =3D min_t(int, limit, ref);
> +       eidx =3D max_t(int, limit, ref);
> +
> +       /* Find total number of slots available; both used and free */
> +       cnt =3D eidx - sidx + 1;
> +       if (contig && cnt < count) {
> +               dev_err(rvu->dev, "%s:%d Wrong ref_enty(%d) or limit(%d) =
for count(%d)\n",
> +                       __func__, __LINE__, ref, limit, count);
> +               return -EINVAL;
> +       }
> +
> +       /* If subbank is free, check if requested number of indexes is le=
ss than
> +        * or equal to mcam entries available in the subbank if contig.
> +        */
> +       if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
> +               if (contig && count > npc_priv.subbank_depth) {
> +                       dev_err(rvu->dev, "%s:%d Less number of entries\n=
",
> +                               __func__, __LINE__);
> +                       goto err;
> +               }
> +
> +               new_sub_bank =3D true;
> +               goto process;
> +       }
> +
> +       /* Flag should be set for all used subbanks */
> +       WARN_ONCE(!(sb->flags & NPC_SUBBANK_FLAG_USED),
> +                 "Used flag is not set(%#x)\n", sb->flags);
> +
> +       /* If subbank key type does not match with requested key_type,
> +        * return error
> +        */
> +       if (sb->key_type !=3D key_type) {
> +               dev_dbg(rvu->dev, "%s:%d subbank key_type mismatch\n",
> +                       __func__, __LINE__);
> +               rc =3D -EINVAL;
> +               goto err;
> +       }
> +
> +process:
> +       /* if ref or limit >=3D npc_priv.bank_depth, index are in bank1.
> +        * else bank0.
> +        */
> +       if (ref >=3D npc_priv.bank_depth) {
> +               bmap =3D sb->b1map;
> +               t =3D sb->b1t;
> +               b =3D sb->b1b;
> +       } else {
> +               bmap =3D sb->b0map;
> +               t =3D sb->b0t;
> +               b =3D sb->b0b;
> +       }
> +
> +       /* Calculate free slots */
> +       bw =3D bitmap_weight(bmap, npc_priv.subbank_depth);
> +       bfree =3D npc_priv.subbank_depth - bw;
> +
> +       if (!bfree) {
> +               rc =3D -ENOSPC;
> +               goto err;
> +       }
> +
> +       /* If request is for contiguous , then max we can allocate is
> +        * equal to subbank_depth
> +        */
> +       if (contig && bfree < count) {
> +               rc =3D -ENOSPC;
> +               dev_err(rvu->dev, "%s:%d no space for entry\n",
> +                       __func__, __LINE__);
> +               goto err;
> +       }
> +
> +       /* 'save' array stores available indexes temporarily before
> +        * marking it as allocated
> +        */
> +       save =3D kcalloc(count, sizeof(u16), GFP_KERNEL);
> +       if (!save) {
> +               rc =3D -ENOMEM;
> +               goto err;
> +       }
> +
> +       if (contig) {
> +               rc =3D  __npc_subbank_contig_alloc(rvu, sb, key_type,
> +                                                sidx, eidx, prio,
> +                                                count, t, b,
> +                                                bmap, save);
> +               /* contiguous allocation success means that
> +                * requested number of free slots got
> +                * allocated
> +                */
> +               if (!rc)
> +                       *alloc_cnt =3D count;
> +
> +       } else {
> +               rc =3D  __npc_subbank_non_contig_alloc(rvu, sb, key_type,
> +                                                    sidx, eidx, prio,
> +                                                    t, b, bmap,
> +                                                    count, save,
> +                                                    max_alloc, alloc_cnt=
);
> +       }
> +
> +       if (rc)
> +               goto err;
> +
> +       /* Mark new subbank bank as used */
> +       if (new_sub_bank) {
> +               blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +               if (blkaddr < 0) {
> +                       dev_err(rvu->dev,
> +                               "%s:%d NPC block not implemented\n",
> +                               __func__, __LINE__);
> +                       goto err;
> +               }
> +
> +               rc =3D  __npc_subbank_mark_used(rvu, sb, key_type);
> +               if (rc) {
> +                       dev_err(rvu->dev, "%s:%d Error to mark subbank as=
 used\n",
> +                               __func__, __LINE__);
> +                       goto err;
> +               }
> +
> +               /* Configure section type to key_type */
> +               rvu_write64(rvu, blkaddr,
> +                           NPC_AF_MCAM_SECTIONX_CFG_EXT(sb->idx),
> +                           key_type);
> +       }
> +
> +       for (i =3D 0; i < *alloc_cnt; i++) {
> +               rc =3D npc_subbank_idx_2_mcam_idx(rvu, sb, save[i], &mcam=
_idx[i]);
> +               if (rc) {
> +                       dev_err(rvu->dev, "%s:%d Error to find mcam idx f=
or %u\n",
> +                               __func__, __LINE__, save[i]);
> +                       /* TODO: handle err case gracefully */
> +                       goto err;
> +               }
> +
> +               /* Mark all slots as used */
> +               ret =3D __npc_subbank_mark_slot(rvu, sb, save[i], true);
> +               if (!ret) {
> +                       dev_err(rvu->dev, "%s:%d Error to mark mcam_idx %=
u\n",
> +                               __func__, __LINE__, mcam_idx[i]);
> +                       rc =3D -EFAULT;
> +                       goto err;
> +               }
> +       }
> +
> +err:
> +       kfree(save);
> +       return rc;
> +}
> +
> +static int __maybe_unused
> +npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
> +                 int key_type, int ref, int limit, int prio,
> +                 bool contig, int count, u16 *mcam_idx,
> +                 int idx_sz, bool max_alloc, int *alloc_cnt)
> +{
> +       int rc;
> +
> +       mutex_lock(&sb->lock);
> +       rc =3D __npc_subbank_alloc(rvu, sb, key_type, ref, limit, prio,
> +                                contig, count, mcam_idx, idx_sz,
> +                                max_alloc, alloc_cnt);
> +       mutex_unlock(&sb->lock);
> +
> +       return rc;
> +}
> +
> +static int __maybe_unused
> +npc_del_from_pf_maps(struct rvu *rvu, u16 mcam_idx)
> +{
> +       int pcifunc, idx;
> +       void *map;
> +
> +       map =3D xa_erase(&npc_priv.xa_idx2pf_map, mcam_idx);
> +       if (!map) {
> +               dev_err(rvu->dev,
> +                       "%s:%d failed to erase mcam_idx(%u) from xa_idx2p=
f map\n",
> +                       __func__, __LINE__, mcam_idx);
> +               return -EFAULT;
> +       }
> +
> +       pcifunc =3D xa_to_value(map);
> +       map =3D xa_load(&npc_priv.xa_pf_map, pcifunc);
> +       idx =3D xa_to_value(map);
> +
> +       map =3D xa_erase(&npc_priv.xa_pf2idx_map[idx], mcam_idx);
> +       if (!map) {
> +               dev_err(rvu->dev,
> +                       "%s:%d failed to erase mcam_idx(%u) from xa_pf2id=
x_map map\n",
> +                       __func__, __LINE__, mcam_idx);
> +               return -EFAULT;
> +       }
> +       return 0;
> +}
> +
> +static int __maybe_unused
> +npc_add_to_pf_maps(struct rvu *rvu, u16 mcam_idx, int pcifunc)
> +{
> +       int rc, idx;
> +       void *map;
> +
> +       dev_dbg(rvu->dev,
> +               "%s:%d add2maps mcam_idx(%u) to xa_idx2pf map pcifunc=3D%=
#x\n",
> +               __func__, __LINE__, mcam_idx, pcifunc);
> +
> +       rc =3D xa_insert(&npc_priv.xa_idx2pf_map, mcam_idx,
> +                      xa_mk_value(pcifunc), GFP_KERNEL);
> +
> +       if (rc) {
> +               map =3D xa_load(&npc_priv.xa_idx2pf_map, mcam_idx);
> +               dev_err(rvu->dev,
> +                       "%s:%d failed to insert mcam_idx(%u) to xa_idx2pf=
 map, existing value=3D%lu\n",
> +                       __func__, __LINE__, mcam_idx, xa_to_value(map));
> +               return -EFAULT;
> +       }
> +
> +       map =3D xa_load(&npc_priv.xa_pf_map, pcifunc);
> +       idx =3D xa_to_value(map);
> +
> +       rc =3D xa_insert(&npc_priv.xa_pf2idx_map[idx], mcam_idx,
> +                      xa_mk_value(pcifunc), GFP_KERNEL);
> +
> +       if (rc) {
> +               map =3D xa_load(&npc_priv.xa_pf2idx_map[idx], mcam_idx);
> +               dev_err(rvu->dev,
> +                       "%s:%d failed to insert mcam_idx(%u) to xa_pf2idx=
_map map, earlier value=3D%lu idx=3D%u\n",
> +                       __func__, __LINE__, mcam_idx, xa_to_value(map), i=
dx);
> +               return -EFAULT;
> +       }
> +
> +       return 0;
> +}
> +
> +static bool __maybe_unused
> +npc_subbank_suits(struct npc_subbank *sb, int key_type)
> +{
> +       mutex_lock(&sb->lock);
> +
> +       if (!sb->key_type) {
> +               mutex_unlock(&sb->lock);
> +               return true;
> +       }
> +
> +       if (sb->key_type =3D=3D key_type) {
> +               mutex_unlock(&sb->lock);
> +               return true;
> +       }
> +
> +       mutex_unlock(&sb->lock);
> +       return false;
> +}
> +
> +#define SB_ALIGN_UP(val)   (((val) + npc_priv.subbank_depth) & \
> +                           ~((npc_priv.subbank_depth) - 1))
> +#define SB_ALIGN_DOWN(val) ALIGN_DOWN((val), npc_priv.subbank_depth)
> +
> +static void npc_subbank_iter_down(struct rvu *rvu,
> +                                 int ref, int limit,
> +                                 int *cur_ref, int *cur_limit,
> +                                 bool *start, bool *stop)
> +{
> +       int align;
> +
> +       *stop =3D false;
> +
> +       /* ALIGN_DOWN the limit to current subbank boundary bottom index =
*/
> +       if (*start) {
> +               *start =3D false;
> +               *cur_ref =3D ref;
> +               align =3D SB_ALIGN_DOWN(ref);
> +               if (align < limit) {
> +                       *stop =3D true;
> +                       *cur_limit =3D limit;
> +                       return;
> +               }
> +               *cur_limit =3D align;
> +               return;
> +       }
> +
> +       *cur_ref =3D *cur_limit - 1;
> +       align =3D *cur_ref - npc_priv.subbank_depth + 1;
> +       if (align <=3D limit) {
> +               *stop =3D true;
> +               *cur_limit =3D limit;
> +               return;
> +       }
> +
> +       *cur_limit =3D align;
> +}
> +
> +static void npc_subbank_iter_up(struct rvu *rvu,
> +                               int ref, int limit,
> +                               int *cur_ref, int *cur_limit,
> +                               bool *start, bool *stop)
> +{
> +       int align;
> +
> +       *stop =3D false;
> +
> +       /* ALIGN_UP the limit to current subbank boundary top index */
> +       if (*start) {
> +               *start =3D false;
> +               *cur_ref =3D ref;
> +
> +               /* Find next lower prio subbank's bottom index */
> +               align =3D SB_ALIGN_UP(ref);
> +
> +               /* Crosses limit ? */
> +               if (align - 1 > limit) {
> +                       *stop =3D true;
> +                       *cur_limit =3D limit;
> +                       return;
> +               }
> +
> +               /* Current subbank's top index */
> +               *cur_limit =3D align - 1;
> +               return;
> +       }
> +
> +       *cur_ref =3D *cur_limit + 1;
> +       align =3D *cur_ref + npc_priv.subbank_depth - 1;
> +
> +       if (align >=3D limit) {
> +               *stop =3D true;
> +               *cur_limit =3D limit;
> +               return;
> +       }
> +
> +       *cur_limit =3D align;
> +}
> +
> +static int __maybe_unused
> +npc_subbank_iter(struct rvu *rvu, int key_type,
> +                int ref, int limit, int prio,
> +                int *cur_ref, int *cur_limit,
> +                bool *start, bool *stop)
> +{
> +       if (prio !=3D NPC_MCAM_HIGHER_PRIO)
> +               npc_subbank_iter_up(rvu, ref, limit,
> +                                   cur_ref, cur_limit,
> +                                   start, stop);
> +       else
> +               npc_subbank_iter_down(rvu, ref, limit,
> +                                     cur_ref, cur_limit,
> +                                     start, stop);
> +
> +       /* limit and ref should < bank_depth for x4 */
> +       if (key_type =3D=3D NPC_MCAM_KEY_X4) {
> +               if (*cur_ref >=3D npc_priv.bank_depth)
> +                       return -EINVAL;
> +
> +               if (*cur_limit >=3D npc_priv.bank_depth)
> +                       return -EINVAL;
> +       }
> +       /* limit and ref should < 2 * bank_depth, for x2 */
> +       if (*cur_ref >=3D 2 * npc_priv.bank_depth)
> +               return -EINVAL;
> +
> +       if (*cur_limit >=3D 2 * npc_priv.bank_depth)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int npc_idx_free(struct rvu *rvu, u16 *mcam_idx, int count,
> +                       bool maps_del)
> +{
> +       struct npc_subbank *sb;
> +       int idx, i;
> +       bool ret;
> +       int rc;
> +
> +       for (i =3D 0; i < count; i++) {
> +               rc =3D  npc_mcam_idx_2_subbank_idx(rvu, mcam_idx[i],
> +                                                &sb, &idx);
> +               if (rc)
> +                       return rc;
> +
> +               ret =3D npc_subbank_free(rvu, sb, idx);
> +               if (ret)
> +                       return -EINVAL;
> +
> +               if (!maps_del)
> +                       continue;
> +
> +               rc =3D npc_del_from_pf_maps(rvu, mcam_idx[i]);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       return 0;
> +}
> +
> +static int npc_multi_subbank_ref_alloc(struct rvu *rvu, int key_type,
> +                                      int ref, int limit, int prio,
> +                                      bool contig, int count,
> +                                      u16 *mcam_idx)
> +{
> +       struct npc_subbank *sb;
> +       unsigned long *bmap;
> +       int sb_off, off, rc;
> +       int cnt =3D 0;
> +       bool bitset;
> +
> +       if (prio !=3D NPC_MCAM_HIGHER_PRIO) {
> +               while (ref <=3D limit) {
> +                       /* Calculate subbank and subbank index */
> +                       rc =3D  npc_mcam_idx_2_subbank_idx(rvu, ref,
> +                                                        &sb, &sb_off);
> +                       if (rc)
> +                               goto err;
> +
> +                       /* If subbank is not suitable for requested key t=
ype
> +                        * restart search from next subbank
> +                        */
> +                       if (!npc_subbank_suits(sb, key_type)) {
> +                               ref =3D SB_ALIGN_UP(ref);
> +                               if (contig) {
> +                                       rc =3D npc_idx_free(rvu, mcam_idx=
,
> +                                                         cnt, false);
> +                                       if (rc)
> +                                               return rc;
> +                                       cnt =3D 0;
> +                               }
> +                               continue;
> +                       }
> +
> +                       mutex_lock(&sb->lock);
> +
> +                       /* If subbank is free; mark it as used */
> +                       if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
> +                               rc =3D  __npc_subbank_mark_used(rvu, sb,
> +                                                             key_type);
> +                               if (rc) {
> +                                       mutex_unlock(&sb->lock);
> +                                       dev_err(rvu->dev,
> +                                               "%s:%d Error to add to us=
e array\n",
> +                                               __func__, __LINE__);
> +                                       goto err;
> +                               }
> +                       }
> +
> +                       /* Find correct bmap */
> +                       __npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap,=
 &off);
> +
> +                       /* if bit is already set, reset 'cnt' */
> +                       bitset =3D test_bit(off, bmap);
> +                       if (bitset) {
> +                               mutex_unlock(&sb->lock);
> +                               if (contig) {
> +                                       rc =3D npc_idx_free(rvu, mcam_idx=
,
> +                                                         cnt, false);
> +                                       if (rc)
> +                                               return rc;
> +                                       cnt =3D 0;
> +                               }
> +
> +                               ref++;
> +                               continue;
> +                       }
> +
> +                       set_bit(off, bmap);
> +                       sb->free_cnt--;
> +                       mcam_idx[cnt++] =3D ref;
> +                       mutex_unlock(&sb->lock);
> +
> +                       if (cnt =3D=3D count)
> +                               return 0;
> +                       ref++;
> +               }
> +
> +               /* Could not allocate request count slots */
> +               goto err;
> +       }
> +       while (ref >=3D limit) {
> +               rc =3D  npc_mcam_idx_2_subbank_idx(rvu, ref,
> +                                                &sb, &sb_off);
> +               if (rc)
> +                       goto err;
> +
> +               if (!npc_subbank_suits(sb, key_type)) {
> +                       ref =3D SB_ALIGN_DOWN(ref) - 1;
> +                       if (contig) {
> +                               rc =3D npc_idx_free(rvu, mcam_idx, cnt, f=
alse);
> +                               if (rc)
> +                                       return rc;
> +
> +                               cnt =3D 0;
> +                       }
> +                       continue;
> +               }
> +
> +               mutex_lock(&sb->lock);
> +
> +               if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
> +                       rc =3D  __npc_subbank_mark_used(rvu, sb, key_type=
);
> +                       if (rc) {
> +                               mutex_unlock(&sb->lock);
> +                               dev_err(rvu->dev,
> +                                       "%s:%d Error to add to use array\=
n",
> +                                       __func__, __LINE__);
> +                               goto err;
> +                       }
> +               }
> +
> +               __npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
> +               bitset =3D test_bit(off, bmap);
> +               if (bitset) {
> +                       mutex_unlock(&sb->lock);
> +                       if (contig) {
> +                               cnt =3D 0;
> +                               rc =3D npc_idx_free(rvu, mcam_idx, cnt, f=
alse);
> +                               if (rc)
> +                                       return rc;
> +                       }
> +                       ref--;
> +                       continue;
> +               }
> +
> +               mcam_idx[cnt++] =3D ref;
> +               sb->free_cnt--;
> +               set_bit(off, bmap);
> +               mutex_unlock(&sb->lock);
> +
> +               if (cnt =3D=3D count)
> +                       return 0;
> +               ref--;
> +       }
> +
> +err:
> +       rc =3D npc_idx_free(rvu, mcam_idx, cnt, false);
> +       if (rc)
> +               dev_err(rvu->dev,
> +                       "%s:%d Error happened while freeing cnt=3D%u inde=
xes\n",
> +                       __func__, __LINE__, cnt);
> +
> +       return -ENOSPC;
> +}
> +
> +static int npc_subbank_free_cnt(struct rvu *rvu, struct npc_subbank *sb,
> +                               int key_type)
> +{
> +       int cnt, spd;
> +
> +       spd =3D npc_priv.subbank_depth;
> +       mutex_lock(&sb->lock);
> +
> +       if (sb->flags & NPC_SUBBANK_FLAG_FREE)
> +               cnt =3D key_type =3D=3D NPC_MCAM_KEY_X4 ? spd : 2 * spd;
> +       else
> +               cnt =3D sb->free_cnt;
> +
> +       mutex_unlock(&sb->lock);
> +       return cnt;
> +}
> +
> +static int npc_subbank_ref_alloc(struct rvu *rvu, int key_type,
> +                                int ref, int limit, int prio,
> +                                bool contig, int count,
> +                                u16 *mcam_idx)
> +{
> +       struct npc_subbank *sb1, *sb2;
> +       bool max_alloc, start, stop;
> +       int r, l, sb_idx1, sb_idx2;
> +       int tot =3D 0, rc;
> +       int alloc_cnt;
> +
> +       max_alloc =3D !contig;
> +
> +       start =3D true;
> +       stop =3D false;
> +
> +       /* Loop until we cross the ref/limit boundary */
> +       while (!stop) {
> +               rc =3D npc_subbank_iter(rvu, key_type, ref, limit, prio,
> +                                     &r, &l, &start, &stop);
> +
> +               dev_dbg(rvu->dev,
> +                       "%s:%d ref=3D%d limit=3D%d r=3D%d l=3D%d start=3D=
%d stop=3D%d tot=3D%d count=3D%d rc=3D%d\n",
> +                       __func__, __LINE__, ref, limit, r, l,
> +                       start, stop, tot, count, rc);
> +
> +               if (rc)
> +                       goto err;
> +
> +               /* Find subbank and subbank index for ref */
> +               rc =3D npc_mcam_idx_2_subbank_idx(rvu, r, &sb1,
> +                                               &sb_idx1);
> +               if (rc)
> +                       goto err;
> +
> +               dev_dbg(rvu->dev,
> +                       "%s:%d ref subbank=3D%d off=3D%d\n",
> +                       __func__, __LINE__, sb1->idx, sb_idx1);
> +
> +               /* Skip subbank if it is not available for the keytype */
> +               if (!npc_subbank_suits(sb1, key_type)) {
> +                       dev_dbg(rvu->dev,
> +                               "%s:%d not suitable sb=3D%d key_type=3D%d=
\n",
> +                               __func__, __LINE__, sb1->idx, key_type);
> +                       continue;
> +               }
> +
> +               /* Find subbank and subbank index for limit */
> +               rc =3D npc_mcam_idx_2_subbank_idx(rvu, l, &sb2,
> +                                               &sb_idx2);
> +               if (rc)
> +                       goto err;
> +
> +               dev_dbg(rvu->dev,
> +                       "%s:%d limit subbank=3D%d off=3D%d\n",
> +                       __func__, __LINE__, sb_idx1, sb_idx2);
> +
> +               /* subbank of ref and limit should be same */
> +               if (sb1 !=3D sb2) {
> +                       dev_err(rvu->dev,
> +                               "%s:%d l(%d) and r(%d) are not in same su=
bbank\n",
> +                               __func__, __LINE__, r, l);
> +                       goto err;
> +               }
> +
> +               if (contig &&
> +                   npc_subbank_free_cnt(rvu, sb1, key_type) < count) {
> +                       dev_dbg(rvu->dev, "%s:%d less count =3D%d\n",
> +                               __func__, __LINE__,
> +                               npc_subbank_free_cnt(rvu, sb1, key_type))=
;
> +                       continue;
> +               }
> +
> +               /* Try in one bank of a subbank */
> +               alloc_cnt =3D 0;
> +               rc =3D  npc_subbank_alloc(rvu, sb1, key_type,
> +                                       r, l, prio, contig,
> +                                       count - tot, mcam_idx + tot,
> +                                       count - tot, max_alloc,
> +                                       &alloc_cnt);
> +
> +               tot +=3D alloc_cnt;
> +
> +               dev_dbg(rvu->dev, "%s:%d Allocated tot=3D%d alloc_cnt=3D%=
d\n",
> +                       __func__, __LINE__, tot, alloc_cnt);
> +
> +               if (!rc && count =3D=3D tot)
> +                       return 0;
> +       }
> +err:
> +       dev_dbg(rvu->dev, "%s:%d Error to allocate\n",
> +               __func__, __LINE__);
> +
> +       /* non contiguous allocation fails. We need to do clean up */
> +       if (max_alloc) {
> +               rc =3D npc_idx_free(rvu, mcam_idx, tot, false);
> +               if (rc)
> +                       dev_err(rvu->dev,
> +                               "%s:%d failed to free %u indexes\n",
> +                               __func__, __LINE__, tot);
> +       }
> +
> +       return -EFAULT;
> +}
> +
> +/* Minimize allocation from bottom and top subbanks for noref allocation=
s.
> + * Default allocations are ref based, and will be allocated from top
> + * subbanks (least priority subbanks). Since default allocation is at ve=
ry
> + * early stage of kernel netdev probes, this subbanks will be moved to
> + * used subbanks list. This will pave a way for noref allocation from th=
ese
> + * used subbanks. Skip allocation for these top and bottom, and try free
> + * bank next. If none slot is available, come back and search in these
> + * subbanks.
> + */
> +
> +static int npc_subbank_restricted_idxs[2];
> +static bool restrict_valid =3D true;
> +
> +static bool npc_subbank_restrict_usage(struct rvu *rvu, int index)
> +{
> +       int i;
> +
> +       if (!restrict_valid)
> +               return false;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(npc_subbank_restricted_idxs); i++) {
> +               if (index =3D=3D npc_subbank_restricted_idxs[i])
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static int npc_subbank_noref_alloc(struct rvu *rvu, int key_type, bool c=
ontig,
> +                                  int count, u16 *mcam_idx)
> +{
> +       struct npc_subbank *sb;
> +       unsigned long index;
> +       int tot =3D 0, rc;
> +       bool max_alloc;
> +       int alloc_cnt;
> +       int idx, i;
> +       void *val;
> +
> +       max_alloc =3D !contig;
> +
> +       /* Check used subbanks for free slots */
> +       xa_for_each(&npc_priv.xa_sb_used, index, val) {
> +               idx =3D xa_to_value(val);
> +
> +               /* Minimize allocation from restricted subbanks
> +                * in noref allocations.
> +                */
> +               if (npc_subbank_restrict_usage(rvu, idx))
> +                       continue;
> +
> +               sb =3D &npc_priv.sb[idx];
> +
> +               /* Skip if not suitable subbank */
> +               if (!npc_subbank_suits(sb, key_type))
> +                       continue;
> +
> +               if (contig && npc_subbank_free_cnt(rvu, sb, key_type) < c=
ount)
> +                       continue;
> +
> +               /* try in bank 0. Try passing ref and limit equal to
> +                * subbank boundaries
> +                */
> +               alloc_cnt =3D 0;
> +               rc =3D  npc_subbank_alloc(rvu, sb, key_type,
> +                                       sb->b0b, sb->b0t, 0,
> +                                       contig, count - tot,
> +                                       mcam_idx + tot,
> +                                       count - tot,
> +                                       max_alloc, &alloc_cnt);
> +
> +               /* Non contiguous allocation may allocate less than
> +                * requested 'count'.
> +                */
> +               tot +=3D alloc_cnt;
> +
> +               dev_dbg(rvu->dev,
> +                       "%s:%d Allocated %d from subbank %d, tot=3D%d cou=
nt=3D%d\n",
> +                       __func__, __LINE__, alloc_cnt, sb->idx, tot, coun=
t);
> +
> +               /* Successfully allocated */
> +               if (!rc && count =3D=3D tot)
> +                       return 0;
> +
> +               /* x4 entries can be allocated from bank 0 only */
> +               if (key_type =3D=3D NPC_MCAM_KEY_X4)
> +                       continue;
> +
> +               /* try in bank 1 for x2 */
> +               alloc_cnt =3D 0;
> +               rc =3D  npc_subbank_alloc(rvu, sb, key_type,
> +                                       sb->b1b, sb->b1t, 0,
> +                                       contig, count - tot,
> +                                       mcam_idx + tot,
> +                                       count - tot, max_alloc,
> +                                       &alloc_cnt);
> +
> +               tot +=3D alloc_cnt;
> +
> +               dev_dbg(rvu->dev,
> +                       "%s:%d Allocated %d from subbank %d, tot=3D%d cou=
nt=3D%d\n",
> +                       __func__, __LINE__, alloc_cnt, sb->idx, tot, coun=
t);
> +
> +               if (!rc && count =3D=3D tot)
> +                       return 0;
> +       }
> +
> +       /* Allocate in free subbanks */
> +       xa_for_each(&npc_priv.xa_sb_free, index, val) {
> +               idx =3D xa_to_value(val);
> +               sb =3D &npc_priv.sb[idx];
> +
> +               /* Minimize allocation from restricted subbanks
> +                * in noref allocations.
> +                */
> +               if (npc_subbank_restrict_usage(rvu, idx))
> +                       continue;
> +
> +               if (!npc_subbank_suits(sb, key_type))
> +                       continue;
> +
> +               /* try in bank 0 */
> +               alloc_cnt =3D 0;
> +               rc =3D  npc_subbank_alloc(rvu, sb, key_type,
> +                                       sb->b0b, sb->b0t, 0,
> +                                       contig, count - tot,
> +                                       mcam_idx + tot,
> +                                       count - tot,
> +                                       max_alloc, &alloc_cnt);
> +
> +               tot +=3D alloc_cnt;
> +
> +               dev_dbg(rvu->dev,
> +                       "%s:%d Allocated %d from subbank %d, tot=3D%d cou=
nt=3D%d\n",
> +                       __func__, __LINE__, alloc_cnt, sb->idx, tot, coun=
t);
> +
> +               /* Successfully allocated */
> +               if (!rc && count =3D=3D tot)
> +                       return 0;
> +
> +               /* x4 entries can be allocated from bank 0 only */
> +               if (key_type =3D=3D NPC_MCAM_KEY_X4)
> +                       continue;
> +
> +               /* try in bank 1 for x2 */
> +               alloc_cnt =3D 0;
> +               rc =3D  npc_subbank_alloc(rvu, sb,
> +                                       key_type, sb->b1b, sb->b1t, 0,
> +                                       contig, count - tot,
> +                                       mcam_idx + tot, count - tot,
> +                                       max_alloc, &alloc_cnt);
> +
> +               tot +=3D alloc_cnt;
> +
> +               dev_dbg(rvu->dev,
> +                       "%s:%d Allocated %d from subbank %d, tot=3D%d cou=
nt=3D%d\n",
> +                       __func__, __LINE__, alloc_cnt, sb->idx, tot, coun=
t);
> +
> +               if (!rc && count =3D=3D tot)
> +                       return 0;
> +       }
> +
> +       /* Allocate from restricted subbanks */
> +       for (i =3D 0; restrict_valid &&
> +            (i < ARRAY_SIZE(npc_subbank_restricted_idxs)); i++) {
> +               idx =3D npc_subbank_restricted_idxs[i];
> +               sb =3D &npc_priv.sb[idx];
> +
> +               /* Skip if not suitable subbank */
> +               if (!npc_subbank_suits(sb, key_type))
> +                       continue;
> +
> +               if (contig && npc_subbank_free_cnt(rvu, sb, key_type) < c=
ount)
> +                       continue;
> +
> +               /* try in bank 0. Try passing ref and limit equal to
> +                * subbank boundaries
> +                */
> +               alloc_cnt =3D 0;
> +               rc =3D  npc_subbank_alloc(rvu, sb, key_type,
> +                                       sb->b0b, sb->b0t, 0,
> +                                       contig, count - tot,
> +                                       mcam_idx + tot,
> +                                       count - tot,
> +                                       max_alloc, &alloc_cnt);
> +
> +               /* Non contiguous allocation may allocate less than
> +                * requested 'count'.
> +                */
> +               tot +=3D alloc_cnt;
> +
> +               dev_dbg(rvu->dev,
> +                       "%s:%d Allocated %d from subbank %d, tot=3D%d cou=
nt=3D%d\n",
> +                       __func__, __LINE__, alloc_cnt, sb->idx, tot, coun=
t);
> +
> +               /* Successfully allocated */
> +               if (!rc && count =3D=3D tot)
> +                       return 0;
> +
> +               /* x4 entries can be allocated from bank 0 only */
> +               if (key_type =3D=3D NPC_MCAM_KEY_X4)
> +                       continue;
> +
> +               /* try in bank 1 for x2 */
> +               alloc_cnt =3D 0;
> +               rc =3D  npc_subbank_alloc(rvu, sb, key_type,
> +                                       sb->b1b, sb->b1t, 0,
> +                                       contig, count - tot,
> +                                       mcam_idx + tot,
> +                                       count - tot, max_alloc,
> +                                       &alloc_cnt);
> +
> +               tot +=3D alloc_cnt;
> +
> +               dev_dbg(rvu->dev,
> +                       "%s:%d Allocated %d from subbank %d, tot=3D%d cou=
nt=3D%d\n",
> +                       __func__, __LINE__, alloc_cnt, sb->idx, tot, coun=
t);
> +
> +               if (!rc && count =3D=3D tot)
> +                       return 0;
> +       }
> +
> +       /* non contiguous allocation fails. We need to do clean up */
> +       if (max_alloc)
> +               npc_idx_free(rvu, mcam_idx, tot, false);
> +
> +       dev_dbg(rvu->dev, "%s:%d non-contig allocation fails\n",
> +               __func__, __LINE__);
> +
> +       return -EFAULT;
> +}
> +
> +int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count)
> +{
> +       return npc_idx_free(rvu, mcam_idx, count, true);
> +}
> +
> +int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
> +                           int prio, u16 *mcam_idx, int ref, int limit,
> +                           bool contig, int count)
> +{
> +       int i, eidx, rc, bd;
> +       bool ref_valid;
> +
> +       bd =3D npc_priv.bank_depth;
> +
> +       /* Special case: ref =3D=3D 0 && limit=3D 0 && prio =3D=3D HIGH &=
& count =3D=3D 1
> +        * Here user wants to allocate 0th entry
> +        */
> +       if (!ref && !limit && prio =3D=3D NPC_MCAM_HIGHER_PRIO &&
> +           count =3D=3D 1) {
> +               rc =3D npc_subbank_ref_alloc(rvu, key_type, ref, limit,
> +                                          prio, contig, count, mcam_idx)=
;
> +
> +               if (rc)
> +                       return rc;
> +               goto add2map;
> +       }
> +
> +       ref_valid =3D !!(limit || ref);
> +       if (!ref_valid) {
> +               if (contig && count > npc_priv.subbank_depth)
> +                       goto try_noref_multi_subbank;
> +
> +               rc =3D npc_subbank_noref_alloc(rvu, key_type, contig,
> +                                            count, mcam_idx);
> +               if (!rc)
> +                       goto add2map;
> +
> +try_noref_multi_subbank:
> +               eidx =3D (key_type =3D=3D NPC_MCAM_KEY_X4) ? bd - 1 : 2 *=
 bd - 1;
> +
> +               if (prio =3D=3D NPC_MCAM_HIGHER_PRIO)
> +                       rc =3D npc_multi_subbank_ref_alloc(rvu, key_type,
> +                                                        eidx, 0,
> +                                                        NPC_MCAM_HIGHER_=
PRIO,
> +                                                        contig, count,
> +                                                        mcam_idx);
> +               else
> +                       rc =3D npc_multi_subbank_ref_alloc(rvu, key_type,
> +                                                        0, eidx,
> +                                                        NPC_MCAM_LOWER_P=
RIO,
> +                                                        contig, count,
> +                                                        mcam_idx);
> +
> +               if (!rc)
> +                       goto add2map;
> +
> +               return rc;
> +       }
> +
> +       if ((prio =3D=3D NPC_MCAM_LOWER_PRIO && ref > limit) ||
> +           (prio =3D=3D NPC_MCAM_HIGHER_PRIO && ref < limit)) {
> +               dev_err(rvu->dev, "%s:%d Wrong ref_enty(%d) or limit(%d)\=
n",
> +                       __func__, __LINE__, ref, limit);
> +               return -EINVAL;
> +       }
> +
> +       if ((key_type =3D=3D NPC_MCAM_KEY_X4 && (ref >=3D bd || limit >=
=3D bd)) ||
> +           (key_type =3D=3D NPC_MCAM_KEY_X2 &&
> +            (ref >=3D 2 * bd || limit >=3D 2 * bd))) {
> +               dev_err(rvu->dev, "%s:%d Wrong ref_enty(%d) or limit(%d)\=
n",
> +                       __func__, __LINE__, ref, limit);
> +               return -EINVAL;
> +       }
> +
> +       if (contig && count > npc_priv.subbank_depth)
> +               goto try_ref_multi_subbank;
> +
> +       rc =3D npc_subbank_ref_alloc(rvu, key_type, ref, limit,
> +                                  prio, contig, count, mcam_idx);
> +       if (!rc)
> +               goto add2map;
> +
> +try_ref_multi_subbank:
> +       rc =3D npc_multi_subbank_ref_alloc(rvu, key_type,
> +                                        ref, limit, prio,
> +                                        contig, count, mcam_idx);
> +       if (!rc)
> +               goto add2map;
> +
> +       return rc;
> +
> +add2map:
> +       for (i =3D 0; i < count; i++) {
> +               rc =3D npc_add_to_pf_maps(rvu, mcam_idx[i], pcifunc);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       return 0;
> +}
> +
> +void npc_cn20k_subbank_calc_free(struct rvu *rvu, int *x2_free,
> +                                int *x4_free, int *sb_free)
> +{
> +       struct npc_subbank *sb;
> +       int i;
> +
> +       /* Reset all stats to zero */
> +       *x2_free =3D 0;
> +       *x4_free =3D 0;
> +       *sb_free =3D 0;
> +
> +       for (i =3D 0; i < npc_priv.num_subbanks; i++) {
> +               sb =3D &npc_priv.sb[i];
> +               mutex_lock(&sb->lock);
> +
> +               /* Count number of free subbanks */
> +               if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
> +                       (*sb_free)++;
> +                       goto next;
> +               }
> +
> +               /* Sumup x4 free count */
> +               if (sb->key_type =3D=3D NPC_MCAM_KEY_X4) {
> +                       (*x4_free) +=3D sb->free_cnt;
> +                       goto next;
> +               }
> +
> +               /* Sumup x2 free counts */
> +               (*x2_free) +=3D sb->free_cnt;
> +next:
> +               mutex_unlock(&sb->lock);
> +       }
> +}
> +
> +int
> +rvu_mbox_handler_npc_cn20k_get_free_count(struct rvu *rvu,
> +                                         struct msg_req *req,
> +                                         struct npc_cn20k_get_free_count=
_rsp *rsp)
> +{
> +       npc_cn20k_subbank_calc_free(rvu, &rsp->free_x2,
> +                                   &rsp->free_x4, &rsp->free_subbanks);
> +       return 0;
[Kalesh] consider changing it to a void function as it unconditionally retu=
rn 0
> +}
> +
> +static void npc_lock_all_subbank(void)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < npc_priv.num_subbanks; i++)
> +               mutex_lock(&npc_priv.sb[i].lock);
> +}
> +
> +static void npc_unlock_all_subbank(void)
> +{
> +       int i;
> +
> +       for (i =3D npc_priv.num_subbanks - 1; i >=3D 0; i--)
> +               mutex_unlock(&npc_priv.sb[i].lock);
> +}
> +
> +static int *subbank_srch_order;
> +
> +int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt)
> +{
> +       struct npc_mcam *mcam =3D &rvu->hw->mcam;
> +       u8 (*fslots)[2], (*uslots)[2];
> +       int fcnt =3D 0, ucnt =3D 0;
> +       struct npc_subbank *sb;
[Kalesh] follow RCT order
> +       unsigned long index;
> +       int idx, val;
> +       void *v;
> +
> +       if (cnt !=3D npc_priv.num_subbanks)
> +               return -EINVAL;
> +
> +       fslots =3D kcalloc(cnt, sizeof(*fslots), GFP_KERNEL);
> +       if (!fslots)
> +               return -ENOMEM;
> +
> +       uslots =3D kcalloc(cnt, sizeof(*uslots), GFP_KERNEL);
> +       if (!uslots)
[Kalesh] missing kfree(fslots);
> +               return -ENOMEM;
> +
> +       for (int i =3D 0; i < cnt; i++, arr++) {
> +               idx =3D (*arr)[0];
> +               val =3D (*arr)[1];
> +
> +               subbank_srch_order[idx] =3D val;
> +       }
> +
> +       /* Lock mcam */
> +       mutex_lock(&mcam->lock);
> +       npc_lock_all_subbank();
> +
> +       restrict_valid =3D false;
> +
> +       xa_for_each(&npc_priv.xa_sb_used, index, v) {
> +               val =3D xa_to_value(v);
> +               (*(uslots + ucnt))[0] =3D index;
> +               (*(uslots + ucnt))[1] =3D val;
> +               xa_erase(&npc_priv.xa_sb_used, index);
> +               ucnt++;
> +       }
> +
> +       xa_for_each(&npc_priv.xa_sb_free, index, v) {
> +               val =3D xa_to_value(v);
> +               (*(fslots + fcnt))[0] =3D index;
> +               (*(fslots + fcnt))[1] =3D val;
> +               xa_erase(&npc_priv.xa_sb_free, index);
> +               fcnt++;
> +       }
> +
> +       for (int i =3D 0; i < ucnt; i++) {
> +               idx  =3D (*(uslots + i))[1];
> +               sb =3D &npc_priv.sb[idx];
> +               sb->arr_idx =3D subbank_srch_order[sb->idx];
> +               xa_store(&npc_priv.xa_sb_used, sb->arr_idx,
> +                        xa_mk_value(sb->idx), GFP_KERNEL);
> +       }
> +
> +       for (int i =3D 0; i < fcnt; i++) {
> +               idx  =3D (*(fslots + i))[1];
> +               sb =3D &npc_priv.sb[idx];
> +               sb->arr_idx =3D subbank_srch_order[sb->idx];
> +               xa_store(&npc_priv.xa_sb_free, sb->arr_idx,
> +                        xa_mk_value(sb->idx), GFP_KERNEL);
> +       }
> +
> +       npc_unlock_all_subbank();
> +       mutex_unlock(&mcam->lock);
> +
> +       kfree(fslots);
> +       kfree(uslots);
> +
> +       return 0;
> +}
> +
> +const int *npc_cn20k_search_order_get(bool *restricted_order)
> +{
> +       *restricted_order =3D restrict_valid;
> +       return subbank_srch_order;
> +}
> +
> +static void npc_populate_restricted_idxs(int num_subbanks)
> +{
> +       npc_subbank_restricted_idxs[0] =3D num_subbanks - 1;
> +       npc_subbank_restricted_idxs[1] =3D 0;
> +}
> +
> +static void npc_create_srch_order(int cnt)
> +{
> +       int val =3D 0;
> +
> +       subbank_srch_order =3D kcalloc(cnt, sizeof(int),
> +                                    GFP_KERNEL);
[Kalesh] missing check for memory allocation failure
> +
> +       for (int i =3D 0; i < cnt; i +=3D 2) {
> +               subbank_srch_order[i] =3D cnt / 2 - val - 1;
> +               subbank_srch_order[i + 1] =3D cnt / 2 + 1 + val;
> +               val++;
> +       }
> +
> +       subbank_srch_order[cnt - 1] =3D cnt / 2;
> +}
> +
> +static void npc_subbank_init(struct rvu *rvu, struct npc_subbank *sb, in=
t idx)
> +{
> +       mutex_init(&sb->lock);
> +
> +       sb->b0b =3D idx * npc_priv.subbank_depth;
> +       sb->b0t =3D sb->b0b + npc_priv.subbank_depth - 1;
> +
> +       sb->b1b =3D npc_priv.bank_depth + idx * npc_priv.subbank_depth;
> +       sb->b1t =3D sb->b1b + npc_priv.subbank_depth - 1;
> +
> +       sb->flags =3D NPC_SUBBANK_FLAG_FREE;
> +       sb->idx =3D idx;
> +       sb->arr_idx =3D subbank_srch_order[idx];
> +
> +       dev_dbg(rvu->dev, "%s:%d sb->idx=3D%u sb->arr_idx=3D%u\n",
> +               __func__, __LINE__, sb->idx, sb->arr_idx);
> +
> +       /* Keep first and last subbank at end of free array; so that
> +        * it will be used at last
> +        */
> +       xa_store(&npc_priv.xa_sb_free, sb->arr_idx,
> +                xa_mk_value(sb->idx), GFP_KERNEL);
> +}
> +
> +static int npc_pcifunc_map_create(struct rvu *rvu)
> +{
> +       int pf, vf, numvfs;
> +       int cnt =3D 0;
> +       u16 pcifunc;
[Kalesh]: follow RCT order
> +       u64 cfg;
> +
> +       for (pf =3D 0; pf < rvu->hw->total_pfs; pf++) {
> +               cfg =3D rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(pf=
));
> +               numvfs =3D (cfg >> 12) & 0xFF;
> +
> +               /* Skip not enabled PFs */
> +               if (!(cfg & BIT_ULL(20)))
> +                       goto chk_vfs;
> +
> +               /* If Admin function, check on VFs */
> +               if (cfg & BIT_ULL(21))
> +                       goto chk_vfs;
> +
> +               pcifunc =3D pf << 9;
> +
> +               xa_store(&npc_priv.xa_pf_map, (unsigned long)pcifunc,
> +                        xa_mk_value(cnt), GFP_KERNEL);
> +
> +               cnt++;
> +
> +chk_vfs:
> +               for (vf =3D 0; vf < numvfs; vf++) {
> +                       pcifunc =3D (pf << 9) | (vf + 1);
> +
> +                       xa_store(&npc_priv.xa_pf_map, (unsigned long)pcif=
unc,
> +                                xa_mk_value(cnt), GFP_KERNEL);
> +                       cnt++;
> +               }
> +       }
> +
> +       return cnt;
> +}
> +
> +static int npc_priv_init(struct rvu *rvu)
> +{
> +       struct npc_mcam *mcam =3D &rvu->hw->mcam;
> +       int blkaddr, num_banks, bank_depth;
> +       int num_subbanks, subbank_depth;
> +       u64 npc_const1, npc_const2 =3D 0;
> +       struct npc_subbank *sb;
> +       u64 cfg;
> +       int i;
> +
> +       blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +       if (blkaddr < 0) {
> +               dev_err(rvu->dev, "%s:%d NPC block not implemented\n",
> +                       __func__, __LINE__);
> +               return -ENODEV;
> +       }
> +
> +       npc_const1 =3D rvu_read64(rvu, blkaddr, NPC_AF_CONST1);
> +       if (npc_const1 & BIT_ULL(63))
> +               npc_const2 =3D rvu_read64(rvu, blkaddr, NPC_AF_CONST2);
> +
> +       num_banks =3D mcam->banks;
> +       bank_depth =3D mcam->banksize;
> +
> +       num_subbanks =3D FIELD_GET(GENMASK_ULL(39, 32), npc_const2);
> +       npc_priv.num_subbanks =3D num_subbanks;
> +
> +       subbank_depth =3D bank_depth / num_subbanks;
> +
> +       npc_priv.bank_depth =3D bank_depth;
> +       npc_priv.subbank_depth =3D subbank_depth;
> +
> +       /* Get kex configured key size */
> +       cfg =3D rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(0));
> +       npc_priv.kw =3D FIELD_GET(GENMASK_ULL(34, 32), cfg);
> +
> +       dev_info(rvu->dev,
> +                "banks=3D%u depth=3D%u, subbanks=3D%u depth=3D%u, key ty=
pe=3D%s\n",
> +                num_banks, bank_depth, num_subbanks, subbank_depth,
> +                npc_kw_name[npc_priv.kw]);
> +
> +       npc_priv.sb =3D kcalloc(num_subbanks, sizeof(struct npc_subbank),
> +                             GFP_KERNEL);
> +       if (!npc_priv.sb)
> +               return -ENOMEM;
> +
> +       xa_init_flags(&npc_priv.xa_sb_used, XA_FLAGS_ALLOC);
> +       xa_init_flags(&npc_priv.xa_sb_free, XA_FLAGS_ALLOC);
> +       xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
> +       xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
> +
> +       npc_create_srch_order(num_subbanks);
> +       npc_populate_restricted_idxs(num_subbanks);
> +
> +       /* Initialize subbanks */
> +       for (i =3D 0, sb =3D npc_priv.sb; i < num_subbanks; i++, sb++)
> +               npc_subbank_init(rvu, sb, i);
> +
> +       /* Get number of pcifuncs in the system */
> +       npc_priv.pf_cnt =3D npc_pcifunc_map_create(rvu);
> +       npc_priv.xa_pf2idx_map =3D kcalloc(npc_priv.pf_cnt, sizeof(struct=
 xarray),
> +                                        GFP_KERNEL);
> +       if (!npc_priv.xa_pf2idx_map)
[Kalesh] missing kfree(npc_priv.sb);
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < npc_priv.pf_cnt; i++)
> +               xa_init_flags(&npc_priv.xa_pf2idx_map[i], XA_FLAGS_ALLOC)=
;
> +
> +       return 0;
> +}
> +
> +int npc_cn20k_deinit(struct rvu *rvu)
[Kalesh] You can change it to a void function as it unconditionally return =
0
> +{
> +       int i;
> +
> +       xa_destroy(&npc_priv.xa_sb_used);
> +       xa_destroy(&npc_priv.xa_sb_free);
> +       xa_destroy(&npc_priv.xa_idx2pf_map);
> +       xa_destroy(&npc_priv.xa_pf_map);
> +
> +       for (i =3D 0; i < npc_priv.pf_cnt; i++)
> +               xa_destroy(&npc_priv.xa_pf2idx_map[i]);
> +
> +       kfree(npc_priv.xa_pf2idx_map);
> +       kfree(npc_priv.sb);
> +       kfree(subbank_srch_order);
> +       return 0;
> +}
> +
> +int npc_cn20k_init(struct rvu *rvu)
> +{
> +       int err;
> +
> +       err =3D npc_priv_init(rvu);
> +       if (err) {
> +               dev_err(rvu->dev, "%s:%d Error to init\n",
> +                       __func__, __LINE__);
> +               return err;
> +       }
> +
> +       npc_priv.init_done =3D true;
> +
> +       return 0;
> +}
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> new file mode 100644
> index 000000000000..e1191d3d03cb
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell RVU Admin Function driver
> + *
> + * Copyright (C) 2026 Marvell.
> + *
> + */
> +
> +#ifndef NPC_CN20K_H
> +#define NPC_CN20K_H
> +
> +#define MAX_NUM_BANKS 2
> +#define MAX_NUM_SUB_BANKS 32
> +#define MAX_SUBBANK_DEPTH 256
> +
> +enum npc_subbank_flag {
> +       NPC_SUBBANK_FLAG_UNINIT,        // npc_subbank is not initialized=
 yet.
[Kalesh] I think the // comments are prohibited
> +       NPC_SUBBANK_FLAG_FREE =3D BIT(0), // No slot allocated
> +       NPC_SUBBANK_FLAG_USED =3D BIT(1), // At least one slot allocated
> +};
> +
> +struct npc_subbank {
> +       u16 b0t, b0b, b1t, b1b;         // mcam indexes of this subbank
> +       enum npc_subbank_flag flags;
> +       struct mutex lock;              // for flags & rsrc modification
> +       DECLARE_BITMAP(b0map, MAX_SUBBANK_DEPTH);       // for x4 and x2
> +       DECLARE_BITMAP(b1map, MAX_SUBBANK_DEPTH);       // for x2 only
> +       u16 idx;        // subbank index, 0 to npc_priv.subbank - 1
> +       u16 arr_idx;    // Index to the free array or used array
> +       u16 free_cnt;   // number of free slots;
> +       u8 key_type;    //NPC_MCAM_KEY_X4 or NPC_MCAM_KEY_X2
> +};
> +
> +struct npc_priv_t {
> +       int bank_depth;
> +       const int num_banks;
> +       int num_subbanks;
> +       int subbank_depth;
> +       u8 kw;                          // Kex configure Keywidth.
> +       struct npc_subbank *sb;         // Array of subbanks
> +       struct xarray xa_sb_used;       // xarray of used subbanks
> +       struct xarray xa_sb_free;       // xarray of free subbanks
> +       struct xarray *xa_pf2idx_map;   // Each PF to map its mcam idxes
> +       struct xarray xa_idx2pf_map;    // Mcam idxes to pf map.
> +       struct xarray xa_pf_map;        // pcifunc to index map.
> +       int pf_cnt;
> +       bool init_done;
> +};
> +
> +struct rvu;
> +
> +struct npc_priv_t *npc_priv_get(void);
> +int npc_cn20k_init(struct rvu *rvu);
> +int npc_cn20k_deinit(struct rvu *rvu);
> +
> +void npc_cn20k_subbank_calc_free(struct rvu *rvu, int *x2_free,
> +                                int *x4_free, int *sb_free);
> +
> +int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
> +                           int prio, u16 *mcam_idx, int ref, int limit,
> +                           bool contig, int count);
> +int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count);
> +int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt);
> +const int *npc_cn20k_search_order_get(bool *restricted_order);
> +
> +#endif /* NPC_CN20K_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> index affb39803120..098b0247848b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> @@ -77,5 +77,8 @@
>  #define RVU_MBOX_VF_INT_ENA_W1S                        (0x30)
>  #define RVU_MBOX_VF_INT_ENA_W1C                        (0x38)
>
> +/* NPC registers */
> +#define NPC_AF_MCAM_SECTIONX_CFG_EXT(a) (0xf000000ull | (a) << 3)
> +
>  #define RVU_MBOX_VF_VFAF_TRIGX(a)              (0x2000 | (a) << 3)
>  #endif /* RVU_MBOX_REG_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers=
/net/ethernet/marvell/octeontx2/af/common.h
> index 8a08bebf08c2..779413a383b7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> @@ -177,10 +177,6 @@ enum nix_scheduler {
>  #define NIX_TX_ACTIONOP_MCAST          (0x3ull)
>  #define NIX_TX_ACTIONOP_DROP_VIOL      (0x5ull)
>
> -#define NPC_MCAM_KEY_X1                        0
> -#define NPC_MCAM_KEY_X2                        1
> -#define NPC_MCAM_KEY_X4                        2
> -
>  #define NIX_INTFX_RX(a)                        (0x0ull | (a) << 1)
>  #define NIX_INTFX_TX(a)                        (0x1ull | (a) << 1)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/n=
et/ethernet/marvell/octeontx2/af/mbox.h
> index a3e273126e4e..73a341980f9e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -52,6 +52,14 @@
>  #define MBOX_DIR_PFVF_UP       6  /* PF sends messages to VF */
>  #define MBOX_DIR_VFPF_UP       7  /* VF replies to PF */
>
> +enum {
> +       NPC_MCAM_KEY_X1 =3D 0,
> +       NPC_MCAM_KEY_DYN =3D NPC_MCAM_KEY_X1,
> +       NPC_MCAM_KEY_X2,
> +       NPC_MCAM_KEY_X4,
> +       NPC_MCAM_KEY_MAX,
> +};
> +
>  enum {
>         TYPE_AFVF,
>         TYPE_AFPF,
> @@ -275,6 +283,8 @@ M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash=
_info,
>  M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,                   =
  \
>                                    npc_get_field_status_req,             =
 \
>                                    npc_get_field_status_rsp)             =
 \
> +M(NPC_CN20K_MCAM_GET_FREE_COUNT, 0x6015, npc_cn20k_get_free_count,      =
\
> +                                msg_req, npc_cn20k_get_free_count_rsp) \
>  /* NIX mbox IDs (range 0x8000 - 0xFFFF) */                             \
>  M(NIX_LF_ALLOC,                0x8000, nix_lf_alloc,                    =
       \
>                                  nix_lf_alloc_req, nix_lf_alloc_rsp)    \
> @@ -1797,6 +1807,14 @@ struct npc_mcam_read_entry_rsp {
>         u8 enable;
>  };
>
> +/* Available entries to use */
> +struct npc_cn20k_get_free_count_rsp {
> +       struct mbox_msghdr hdr;
> +       int free_x2;
> +       int free_x4;
> +       int free_subbanks;
> +};
> +
>  struct npc_mcam_read_base_rule_rsp {
>         struct mbox_msghdr hdr;
>         struct mcam_entry entry;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/dr=
ivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 15d3cb0b9da6..425d3a43c0b8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -3745,6 +3745,9 @@ static void rvu_dbg_npc_init(struct rvu *rvu)
>         debugfs_create_file("rx_miss_act_stats", 0444, rvu->rvu_dbg.npc, =
rvu,
>                             &rvu_dbg_npc_rx_miss_act_fops);
>
> +       if (is_cn20k(rvu->pdev))
> +               npc_cn20k_debugfs_init(rvu);
> +
>         if (!rvu->hw->cap.npc_exact_match_enabled)
>                 return;
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/driver=
s/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index c7c70429eb6c..6c5fe838717e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -16,6 +16,7 @@
>  #include "cgx.h"
>  #include "npc_profile.h"
>  #include "rvu_npc_hash.h"
> +#include "cn20k/npc.h"
>
>  #define RSVD_MCAM_ENTRIES_PER_PF       3 /* Broadcast, Promisc and AllMu=
lticast */
>  #define RSVD_MCAM_ENTRIES_PER_NIXLF    1 /* Ucast for LFs */
> @@ -2159,6 +2160,9 @@ int rvu_npc_init(struct rvu *rvu)
>                 npc_load_mkex_profile(rvu, blkaddr, def_pfl_name);
>         }
>
> +       if (is_cn20k(rvu->pdev))
> +               return npc_cn20k_init(rvu);
> +
>         return 0;
>  }
>
> @@ -2174,6 +2178,9 @@ void rvu_npc_freemem(struct rvu *rvu)
>         else
>                 kfree(rvu->kpu_fwdata);
>         mutex_destroy(&mcam->lock);
> +
> +       if (is_cn20k(rvu->pdev))
> +               npc_cn20k_deinit(rvu);
>  }
>
>  void rvu_npc_get_mcam_entry_alloc_info(struct rvu *rvu, u16 pcifunc,
> @@ -3029,7 +3036,6 @@ static int __npc_mcam_alloc_counter(struct rvu *rvu=
,
>         if (!req->contig && req->count > NPC_MAX_NONCONTIG_COUNTERS)
>                 return NPC_MCAM_INVALID_REQ;
>
> -
[Kalesh] looks unrelated change
>         /* Check if unused counters are available or not */
>         if (!rvu_rsrc_free_count(&mcam->counters)) {
>                 return NPC_MCAM_ALLOC_FAILED;
> --
> 2.43.0
>
>


--=20
Regards,
Kalesh AP

--00000000000099dd970647b3c77a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVgQYJKoZIhvcNAQcCoIIVcjCCFW4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLuMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGtzCCBJ+g
AwIBAgIMEvVs5DNhf00RSyR0MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDI1N1oXDTI3MDYyMTEzNDI1N1owgfUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEYMBYGA1UEBBMPQW5ha2t1ciBQdXJheWlsMQ8wDQYDVQQqEwZLYWxlc2gxFjAUBgNVBAoT
DUJST0FEQ09NIElOQy4xLDAqBgNVBAMMI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20u
Y29tMTIwMAYJKoZIhvcNAQkBFiNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOG5Nf+oQkB79NOTXl/T/Ixz4F6jXeF0+Qnn
3JsEcyfkKD4bFwFz3ruqhN2XmFFaK0T8gjJ3ZX5J7miihNKl0Jxo5asbWsM4wCQLdq3/+QwN/xAm
+ZAt/5BgDoPqdN61YPyPs8KNAQ8zHt8iZA0InZgmNkDcHhnOJ38cszc1S0eSlOqFa4W9TiQXDRYT
NFREznPoL3aCNNbDPWAkAc+0/X1XdV1kt4D9jrei4RoDevg15euOaij9X7stUsj+IMgzCt2Fyp7+
CeElPmNQ0YOba2ws52no4x/sT5R2k3DTPisRieErWuQNhePfW2fZFFXYv7N2LMgfMi9hiLi2Q3eO
1jMCAwEAAaOCAecwggHjMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcB
AQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2ln
bi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAy
ASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwLgYDVR0RBCcwJYEja2FsZXNoLWFuYWtrdXIucHVyYXlp
bEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+v
LVAt26AjhRiwoJIwHQYDVR0OBBYEFJ/R8BNY0JEVQpirvzzFQFgflqtJMA0GCSqGSIb3DQEBCwUA
A4ICAQCLsxTSA9ERT90FGuX/UM2ZQboBpTPs7DwZPq12XIrkD58GkHWgWAYS2xL1yyvD7pEtN28N
8d4+o6IcPz7yPrfWUCCpAitaeSbu0QiZzIAZlFWNUaOXCgZmHam8Oc+Lp/+XJFrRLhNkzczcw3zT
cyViuRF/upsrQ3KY/kqimiQjR9BduvKiX/w/tMWDib1UhbVhXxuhuWMr8j8sja2/QR9fk670ViD9
amx7b5x595AulQfiDhcN0qxG4fr7L22Y/RYX8fCoBAGo0SF7IpxSukVsp6z5uZp5ggdNr2Cq88qk
if7GG/Oy1beosYD9I5S5dIRcP25oNbcJkbCb/GuvWegzGfxCCBuirb09mTSZRxaBmb1P6dANmPvh
PdqGqxfFrXagvwbO15DN46GarD9KiHa8QHyTtWghL3q+G6ZHlZUWnyS4YMacrx8Ngy0x7HR4dNdT
pqAqOOsOwDmQFBNRYomMdAaOXm6x6MFDnp51sIWVNGWK2u4le2VI6RJMzEqLzMZKL0vTW+HPqMaT
hWv2s5x6cJdLio1vP63rDxJS7vH++zMaY0Jcptrx6eAhzfcq+y/TkHJaZ4dWrtbof1yw3z5EpCvT
YDxV0XFQiCRLNKuZhkVvQ8dtmVhcpiT/mENrWKWOt0DwNEeC/3Fr1ruoyriggbnRmBQt1bC5uxfv
+CEHcDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDBL1bOQzYX9NEUsk
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgvTRq+Z53anCGc2VB1exLMZU/r2X5
FtjrCKL7klVXh6owGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTA2MDgxNTMzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAyBa+aPieSXYk7KQF7mJ2eiapfebvfGRuHnCGiq6aut7W4urRzC1txG+6SZn/i27b
eSdkhKtP4uCZDXGSe4sWu1bz9p15fPsdHjSF9ITDntmUgCifyXUftx3p0jsXVlVsxWoOgSlW0B9z
2bba2k0xfdJnwS9wDTYUIE7DFDw0xFu/XjGQF6gE3UivY7qmqVatvDpskKpmxWytQDBEeCkMm9JA
o8vf1l10Kchbv/pD35ZSCXh+gWdCbyMd9PiQcxjEFm436J6hB94rQSAQHjD/hJoyThf7ybT3A2/v
yQCXyqkHX2+kAJHb9spXNyNhKmjTFoAyEpYuJJMB3E+gGlDPJA==
--00000000000099dd970647b3c77a--

