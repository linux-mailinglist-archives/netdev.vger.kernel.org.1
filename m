Return-Path: <netdev+bounces-196406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA5CAD4863
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 04:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8946A176B46
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 02:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484B170A26;
	Wed, 11 Jun 2025 02:11:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF533146A68;
	Wed, 11 Jun 2025 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749607863; cv=none; b=tRI2L02DkK/r+hIf0eyiYQhM0oiV8zwM1R+ZvSgGUm8+Wh84i0bQBJYO2hM9kC9YnvyVwhnvWqq8TXQmoI3bUYxXmaCJtUTEVA1kWBWfnZtlqt5HMttbOh2HVzRg0nzrpPmb9Sj2xJ8GMjxZFPYJmihZ04DqyAyh/wVU67suacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749607863; c=relaxed/simple;
	bh=o7Gy4ytysOvhxmYyFhbh0yG9Bq0S9o6yshk/reC0e7w=;
	h=Content-Type:Message-ID:Date:MIME-Version:CC:Subject:To:
	 References:From:In-Reply-To; b=kv91rSC6p9fnqsF1W2oXDL7/wDHoqhURpeLVG5GMyKiGk6/RadK8L1cNoj/gpz/bWDa4pEAlPW23TnLqov7E0JKlHSsbvCca0qQP8Q0dBkjZh7TIstWf0w/IfwqrSvrdANdD7CKeO3iYbAklGhKWRaDvzSF5Gkp2iPZdf3n++UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bH8Gb5KBPz13M0q;
	Wed, 11 Jun 2025 10:08:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CEEA6180087;
	Wed, 11 Jun 2025 10:10:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Jun 2025 10:10:56 +0800
Content-Type: multipart/mixed;
	boundary="------------IY1xpdlth33AzuNjsrvPDI7a"
Message-ID: <41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
Date: Wed, 11 Jun 2025 10:10:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Hao Lan <lanhao@huawei.com>, Guangwei Zhang
	<zhangwangwei6@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH] hns3: work around stack size warning
To: Arnd Bergmann <arnd@kernel.org>, Jian Shen <shenjian15@huawei.com>, Salil
 Mehta <salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nathan
 Chancellor <nathan@kernel.org>
References: <20250610092113.2639248-1-arnd@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250610092113.2639248-1-arnd@kernel.org>
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

--------------IY1xpdlth33AzuNjsrvPDI7a
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


on 2025/6/10 17:21, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The hns3 debugfs functions all use an extra on-stack buffer to store
> temporary text output before copying that to the debugfs file.
>
> In some configurations with clang, this can trigger the warning limit
> for the total stack size:
>
>   drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:788:12: error: stack frame size (1456) exceeds limit (1280) in 'hns3_dbg_tx_queue_info' [-Werror,-Wframe-larger-than]
>
> The problem here is that both hns3_dbg_tx_spare_info() and
> hns3_dbg_tx_queue_info() have a large on-stack buffer, and clang decides
> to inline them into a single function.

Hi Arnd:

Thank you for your report.

>
> Annotate hns3_dbg_tx_spare_info() as noinline_for_stack to force the
> behavior that gcc has, regardless of the compiler.
>
> Ideally all the functions in here would be changed to avoid on-stack
> output buffers.

Would you please help test whether the following changes have solved your problem,
And I'm not sure if this patch should be sent to net or net-next...


 From d8d1ec419d45411762dd1c8ba24510e5a40bad08 Mon Sep 17 00:00:00 2001
From: Jian Shen <shenjian15@huawei.com>
Date: Tue, 10 Jun 2025 19:35:19 +0800
Subject: [PATCH] net: hns3: clean up compile warning in debugfs

Arnd reported that there are two build warning for on-stasck
buffer oversize[1]. So use kmalloc instead of on-stack buffer.

1: https://lore.kernel.org/all/20250610092113.2639248-1-arnd@kernel.org/
Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Jian Shen <shenjian15@huawei.com>
---
  .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 37 ++++++++++++-------
  1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index dd86a3f66040..0246d9ef26ab 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -592,10 +592,11 @@ static const struct hns3_dbg_item tx_spare_info_items[] = {
  static void hns3_dbg_tx_spare_info(struct hns3_enet_ring *ring, char *buf,
  				   int len, u32 ring_num, int *pos)
  {
-	char data_str[ARRAY_SIZE(tx_spare_info_items)][HNS3_DBG_DATA_STR_LEN];
+	size_t item_num = ARRAY_SIZE(tx_spare_info_items);
  	struct hns3_tx_spare *tx_spare = ring->tx_spare;
  	char *result[ARRAY_SIZE(tx_spare_info_items)];
  	char content[HNS3_DBG_INFO_LEN];
+	char *data_str;
  	u32 i, j;
  
  	if (!tx_spare) {
@@ -604,12 +605,16 @@ static void hns3_dbg_tx_spare_info(struct hns3_enet_ring *ring, char *buf,
  		return;
  	}
  
-	for (i = 0; i < ARRAY_SIZE(tx_spare_info_items); i++)
-		result[i] = &data_str[i][0];
+	data_str = kzalloc(item_num * HNS3_DBG_DATA_STR_LEN, GFP_KERNEL);
+	if (!data_str)
+		return;
+
+	for (i = 0; i < item_num; i++)
+		result[i] = &data_str[i * HNS3_DBG_DATA_STR_LEN];
  
  	*pos += scnprintf(buf + *pos, len - *pos, "tx spare buffer info\n");
  	hns3_dbg_fill_content(content, sizeof(content), tx_spare_info_items,
-			      NULL, ARRAY_SIZE(tx_spare_info_items));
+			      NULL, item_num);
  	*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
  
  	for (i = 0; i < ring_num; i++) {
@@ -623,10 +628,11 @@ static void hns3_dbg_tx_spare_info(struct hns3_enet_ring *ring, char *buf,
  		sprintf(result[j++], "%pad", &tx_spare->dma);
  		hns3_dbg_fill_content(content, sizeof(content),
  				      tx_spare_info_items,
-				      (const char **)result,
-				      ARRAY_SIZE(tx_spare_info_items));
+				      (const char **)result, item_num);
  		*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
  	}
+
+	kfree(data_str);
  }
  
  static const struct hns3_dbg_item rx_queue_info_items[] = {
@@ -793,12 +799,13 @@ static void hns3_dump_tx_queue_info(struct hns3_enet_ring *ring,
  static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
  				  char *buf, int len)
  {
-	char data_str[ARRAY_SIZE(tx_queue_info_items)][HNS3_DBG_DATA_STR_LEN];
+	size_t item_num = ARRAY_SIZE(tx_queue_info_items);
  	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
  	char *result[ARRAY_SIZE(tx_queue_info_items)];
  	struct hns3_nic_priv *priv = h->priv;
  	char content[HNS3_DBG_INFO_LEN];
  	struct hns3_enet_ring *ring;
+	char *data_str;
  	int pos = 0;
  	u32 i;
  
@@ -807,11 +814,15 @@ static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
  		return -EFAULT;
  	}
  
-	for (i = 0; i < ARRAY_SIZE(tx_queue_info_items); i++)
-		result[i] = &data_str[i][0];
+	data_str = kzalloc(item_num * HNS3_DBG_DATA_STR_LEN, GFP_KERNEL);
+	if (!data_str)
+		return -ENOMEM;
+
+	for (i = 0; i < item_num; i++)
+		result[i] = &data_str[i * HNS3_DBG_DATA_STR_LEN];
  
  	hns3_dbg_fill_content(content, sizeof(content), tx_queue_info_items,
-			      NULL, ARRAY_SIZE(tx_queue_info_items));
+			      NULL, item_num);
  	pos += scnprintf(buf + pos, len - pos, "%s", content);
  
  	for (i = 0; i < h->kinfo.num_tqps; i++) {
@@ -827,13 +838,13 @@ static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
  		hns3_dump_tx_queue_info(ring, ae_dev, result, i);
  		hns3_dbg_fill_content(content, sizeof(content),
  				      tx_queue_info_items,
-				      (const char **)result,
-				      ARRAY_SIZE(tx_queue_info_items));
+				      (const char **)result, item_num);
  		pos += scnprintf(buf + pos, len - pos, "%s", content);
  	}
  
-	hns3_dbg_tx_spare_info(ring, buf, len, h->kinfo.num_tqps, &pos);
+	kfree(data_str);
  
+	hns3_dbg_tx_spare_info(ring, buf, len, h->kinfo.num_tqps, &pos);
  	return 0;
  }
  
-- 
2.33.0


Thanks very much!

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> index 4e5d8bc39a1b..97dc47eeb44c 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> @@ -580,8 +580,9 @@ static const struct hns3_dbg_item tx_spare_info_items[] = {
>   	{ "DMA", 17 },
>   };
>   
> -static void hns3_dbg_tx_spare_info(struct hns3_enet_ring *ring, char *buf,
> -				   int len, u32 ring_num, int *pos)
> +static noinline_for_stack void
> +hns3_dbg_tx_spare_info(struct hns3_enet_ring *ring, char *buf,
> +			int len, u32 ring_num, int *pos)
>   {
>   	char data_str[ARRAY_SIZE(tx_spare_info_items)][HNS3_DBG_DATA_STR_LEN];
>   	struct hns3_tx_spare *tx_spare = ring->tx_spare;
--------------IY1xpdlth33AzuNjsrvPDI7a
Content-Type: text/plain; charset="UTF-8";
	name="0001-net-hns3-clean-up-compile-w.patch"
Content-Disposition: attachment;
	filename="0001-net-hns3-clean-up-compile-w.patch"
Content-Transfer-Encoding: base64

RnJvbSBkOGQxZWM0MTlkNDU0MTE3NjJkZDFjOGJhMjQ1MTBlNWE0MGJhZDA4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKaWFuIFNoZW4gPHNoZW5qaWFuMTVAaHVhd2VpLmNv
bT4KRGF0ZTogVHVlLCAxMCBKdW4gMjAyNSAxOTozNToxOSArMDgwMApTdWJqZWN0OiBbUEFU
Q0hdIG5ldDogaG5zMzogY2xlYW4gdXAgY29tcGlsZSB3YXJuaW5nIGluIGRlYnVnZnMKCkFy
bmQgcmVwb3J0ZWQgdGhhdCB0aGVyZSBhcmUgdHdvIGJ1aWxkIHdhcm5pbmcgZm9yIG9uLXN0
YXNjawpidWZmZXIgb3ZlcnNpemVbMV0uIFNvIHVzZSBrbWFsbG9jIGluc3RlYWQgb2Ygb24t
c3RhY2sgYnVmZmVyLgoKMTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwNjEw
MDkyMTEzLjI2MzkyNDgtMS1hcm5kQGtlcm5lbC5vcmcvClJlcG9ydGVkLWJ5OiBBcm5kIEJl
cmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IEppYW4gU2hlbiA8c2hl
bmppYW4xNUBodWF3ZWkuY29tPgotLS0KIC4uLi9ldGhlcm5ldC9oaXNpbGljb24vaG5zMy9o
bnMzX2RlYnVnZnMuYyAgICB8IDM3ICsrKysrKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2RlYnVnZnMuYyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZGVidWdmcy5jCmluZGV4
IGRkODZhM2Y2NjA0MC4uMDI0NmQ5ZWYyNmFiIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2RlYnVnZnMuYworKysgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2RlYnVnZnMuYwpAQCAtNTkyLDEwICs1
OTIsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBobnMzX2RiZ19pdGVtIHR4X3NwYXJlX2lu
Zm9faXRlbXNbXSA9IHsKIHN0YXRpYyB2b2lkIGhuczNfZGJnX3R4X3NwYXJlX2luZm8oc3Ry
dWN0IGhuczNfZW5ldF9yaW5nICpyaW5nLCBjaGFyICpidWYsCiAJCQkJICAgaW50IGxlbiwg
dTMyIHJpbmdfbnVtLCBpbnQgKnBvcykKIHsKLQljaGFyIGRhdGFfc3RyW0FSUkFZX1NJWkUo
dHhfc3BhcmVfaW5mb19pdGVtcyldW0hOUzNfREJHX0RBVEFfU1RSX0xFTl07CisJc2l6ZV90
IGl0ZW1fbnVtID0gQVJSQVlfU0laRSh0eF9zcGFyZV9pbmZvX2l0ZW1zKTsKIAlzdHJ1Y3Qg
aG5zM190eF9zcGFyZSAqdHhfc3BhcmUgPSByaW5nLT50eF9zcGFyZTsKIAljaGFyICpyZXN1
bHRbQVJSQVlfU0laRSh0eF9zcGFyZV9pbmZvX2l0ZW1zKV07CiAJY2hhciBjb250ZW50W0hO
UzNfREJHX0lORk9fTEVOXTsKKwljaGFyICpkYXRhX3N0cjsKIAl1MzIgaSwgajsKIAogCWlm
ICghdHhfc3BhcmUpIHsKQEAgLTYwNCwxMiArNjA1LDE2IEBAIHN0YXRpYyB2b2lkIGhuczNf
ZGJnX3R4X3NwYXJlX2luZm8oc3RydWN0IGhuczNfZW5ldF9yaW5nICpyaW5nLCBjaGFyICpi
dWYsCiAJCXJldHVybjsKIAl9CiAKLQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh0eF9z
cGFyZV9pbmZvX2l0ZW1zKTsgaSsrKQotCQlyZXN1bHRbaV0gPSAmZGF0YV9zdHJbaV1bMF07
CisJZGF0YV9zdHIgPSBremFsbG9jKGl0ZW1fbnVtICogSE5TM19EQkdfREFUQV9TVFJfTEVO
LCBHRlBfS0VSTkVMKTsKKwlpZiAoIWRhdGFfc3RyKQorCQlyZXR1cm47CisKKwlmb3IgKGkg
PSAwOyBpIDwgaXRlbV9udW07IGkrKykKKwkJcmVzdWx0W2ldID0gJmRhdGFfc3RyW2kgKiBI
TlMzX0RCR19EQVRBX1NUUl9MRU5dOwogCiAJKnBvcyArPSBzY25wcmludGYoYnVmICsgKnBv
cywgbGVuIC0gKnBvcywgInR4IHNwYXJlIGJ1ZmZlciBpbmZvXG4iKTsKIAlobnMzX2RiZ19m
aWxsX2NvbnRlbnQoY29udGVudCwgc2l6ZW9mKGNvbnRlbnQpLCB0eF9zcGFyZV9pbmZvX2l0
ZW1zLAotCQkJICAgICAgTlVMTCwgQVJSQVlfU0laRSh0eF9zcGFyZV9pbmZvX2l0ZW1zKSk7
CisJCQkgICAgICBOVUxMLCBpdGVtX251bSk7CiAJKnBvcyArPSBzY25wcmludGYoYnVmICsg
KnBvcywgbGVuIC0gKnBvcywgIiVzIiwgY29udGVudCk7CiAKIAlmb3IgKGkgPSAwOyBpIDwg
cmluZ19udW07IGkrKykgewpAQCAtNjIzLDEwICs2MjgsMTEgQEAgc3RhdGljIHZvaWQgaG5z
M19kYmdfdHhfc3BhcmVfaW5mbyhzdHJ1Y3QgaG5zM19lbmV0X3JpbmcgKnJpbmcsIGNoYXIg
KmJ1ZiwKIAkJc3ByaW50ZihyZXN1bHRbaisrXSwgIiVwYWQiLCAmdHhfc3BhcmUtPmRtYSk7
CiAJCWhuczNfZGJnX2ZpbGxfY29udGVudChjb250ZW50LCBzaXplb2YoY29udGVudCksCiAJ
CQkJICAgICAgdHhfc3BhcmVfaW5mb19pdGVtcywKLQkJCQkgICAgICAoY29uc3QgY2hhciAq
KilyZXN1bHQsCi0JCQkJICAgICAgQVJSQVlfU0laRSh0eF9zcGFyZV9pbmZvX2l0ZW1zKSk7
CisJCQkJICAgICAgKGNvbnN0IGNoYXIgKiopcmVzdWx0LCBpdGVtX251bSk7CiAJCSpwb3Mg
Kz0gc2NucHJpbnRmKGJ1ZiArICpwb3MsIGxlbiAtICpwb3MsICIlcyIsIGNvbnRlbnQpOwog
CX0KKworCWtmcmVlKGRhdGFfc3RyKTsKIH0KIAogc3RhdGljIGNvbnN0IHN0cnVjdCBobnMz
X2RiZ19pdGVtIHJ4X3F1ZXVlX2luZm9faXRlbXNbXSA9IHsKQEAgLTc5MywxMiArNzk5LDEz
IEBAIHN0YXRpYyB2b2lkIGhuczNfZHVtcF90eF9xdWV1ZV9pbmZvKHN0cnVjdCBobnMzX2Vu
ZXRfcmluZyAqcmluZywKIHN0YXRpYyBpbnQgaG5zM19kYmdfdHhfcXVldWVfaW5mbyhzdHJ1
Y3QgaG5hZTNfaGFuZGxlICpoLAogCQkJCSAgY2hhciAqYnVmLCBpbnQgbGVuKQogewotCWNo
YXIgZGF0YV9zdHJbQVJSQVlfU0laRSh0eF9xdWV1ZV9pbmZvX2l0ZW1zKV1bSE5TM19EQkdf
REFUQV9TVFJfTEVOXTsKKwlzaXplX3QgaXRlbV9udW0gPSBBUlJBWV9TSVpFKHR4X3F1ZXVl
X2luZm9faXRlbXMpOwogCXN0cnVjdCBobmFlM19hZV9kZXYgKmFlX2RldiA9IGhuczNfZ2V0
X2FlX2RldihoKTsKIAljaGFyICpyZXN1bHRbQVJSQVlfU0laRSh0eF9xdWV1ZV9pbmZvX2l0
ZW1zKV07CiAJc3RydWN0IGhuczNfbmljX3ByaXYgKnByaXYgPSBoLT5wcml2OwogCWNoYXIg
Y29udGVudFtITlMzX0RCR19JTkZPX0xFTl07CiAJc3RydWN0IGhuczNfZW5ldF9yaW5nICpy
aW5nOworCWNoYXIgKmRhdGFfc3RyOwogCWludCBwb3MgPSAwOwogCXUzMiBpOwogCkBAIC04
MDcsMTEgKzgxNCwxNSBAQCBzdGF0aWMgaW50IGhuczNfZGJnX3R4X3F1ZXVlX2luZm8oc3Ry
dWN0IGhuYWUzX2hhbmRsZSAqaCwKIAkJcmV0dXJuIC1FRkFVTFQ7CiAJfQogCi0JZm9yIChp
ID0gMDsgaSA8IEFSUkFZX1NJWkUodHhfcXVldWVfaW5mb19pdGVtcyk7IGkrKykKLQkJcmVz
dWx0W2ldID0gJmRhdGFfc3RyW2ldWzBdOworCWRhdGFfc3RyID0ga3phbGxvYyhpdGVtX251
bSAqIEhOUzNfREJHX0RBVEFfU1RSX0xFTiwgR0ZQX0tFUk5FTCk7CisJaWYgKCFkYXRhX3N0
cikKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlmb3IgKGkgPSAwOyBpIDwgaXRlbV9udW07IGkr
KykKKwkJcmVzdWx0W2ldID0gJmRhdGFfc3RyW2kgKiBITlMzX0RCR19EQVRBX1NUUl9MRU5d
OwogCiAJaG5zM19kYmdfZmlsbF9jb250ZW50KGNvbnRlbnQsIHNpemVvZihjb250ZW50KSwg
dHhfcXVldWVfaW5mb19pdGVtcywKLQkJCSAgICAgIE5VTEwsIEFSUkFZX1NJWkUodHhfcXVl
dWVfaW5mb19pdGVtcykpOworCQkJICAgICAgTlVMTCwgaXRlbV9udW0pOwogCXBvcyArPSBz
Y25wcmludGYoYnVmICsgcG9zLCBsZW4gLSBwb3MsICIlcyIsIGNvbnRlbnQpOwogCiAJZm9y
IChpID0gMDsgaSA8IGgtPmtpbmZvLm51bV90cXBzOyBpKyspIHsKQEAgLTgyNywxMyArODM4
LDEzIEBAIHN0YXRpYyBpbnQgaG5zM19kYmdfdHhfcXVldWVfaW5mbyhzdHJ1Y3QgaG5hZTNf
aGFuZGxlICpoLAogCQlobnMzX2R1bXBfdHhfcXVldWVfaW5mbyhyaW5nLCBhZV9kZXYsIHJl
c3VsdCwgaSk7CiAJCWhuczNfZGJnX2ZpbGxfY29udGVudChjb250ZW50LCBzaXplb2YoY29u
dGVudCksCiAJCQkJICAgICAgdHhfcXVldWVfaW5mb19pdGVtcywKLQkJCQkgICAgICAoY29u
c3QgY2hhciAqKilyZXN1bHQsCi0JCQkJICAgICAgQVJSQVlfU0laRSh0eF9xdWV1ZV9pbmZv
X2l0ZW1zKSk7CisJCQkJICAgICAgKGNvbnN0IGNoYXIgKiopcmVzdWx0LCBpdGVtX251bSk7
CiAJCXBvcyArPSBzY25wcmludGYoYnVmICsgcG9zLCBsZW4gLSBwb3MsICIlcyIsIGNvbnRl
bnQpOwogCX0KIAotCWhuczNfZGJnX3R4X3NwYXJlX2luZm8ocmluZywgYnVmLCBsZW4sIGgt
PmtpbmZvLm51bV90cXBzLCAmcG9zKTsKKwlrZnJlZShkYXRhX3N0cik7CiAKKwlobnMzX2Ri
Z190eF9zcGFyZV9pbmZvKHJpbmcsIGJ1ZiwgbGVuLCBoLT5raW5mby5udW1fdHFwcywgJnBv
cyk7CiAJcmV0dXJuIDA7CiB9CiAKLS0gCjIuMzMuMAoK

--------------IY1xpdlth33AzuNjsrvPDI7a--

