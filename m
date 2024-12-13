Return-Path: <netdev+bounces-151770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933839F0D0E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5557B28314D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C431DFE2C;
	Fri, 13 Dec 2024 13:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F18F19AA58;
	Fri, 13 Dec 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095517; cv=none; b=K8kun04Z1KtqYrHzyLd1bxkJ2Cz+69GLuvcaZPoJ6Ca/lfOYgfqvPEIEEVRuLUqfotDIBNGyqWfjDFZKwngb63Vv5mKSaz6lDNvL/umsCpMC197BUR4wCxNziGT5YIMZjJccTXz9otwFi4c7jfWEvGVKG7ez65xzQkc3rPA+r4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095517; c=relaxed/simple;
	bh=g2nLpU0bqiewCWWl7q7f8Y20UQ5FJfmstD4qoaMlUEM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gndhtalq5vGsZzwRXqVUzwIFOAJbEMDsskH5PkKQUUd6PD4CRdbVGS3GDS5UD6XiI+A+Kvh6lFhx5n/+Bv+hAc4g7hPoQN03jFE+J0D7iulau/rB+8Qtuog5Fm7Nwa5iTZLzgTTogu0XcgvuCWzqDBDepu/HTwWUqwx5Jn+BgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y8qSX2j6wzqTjy;
	Fri, 13 Dec 2024 21:10:04 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A8A11800D9;
	Fri, 13 Dec 2024 21:11:51 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Dec 2024 21:11:50 +0800
Message-ID: <1448b4a1-235c-4abe-9f95-fbf6e7f9d640@huawei.com>
Date: Fri, 13 Dec 2024 21:11:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <salil.mehta@huawei.com>, <liuyonglong@huawei.com>,
	<wangpeiyang1@huawei.com>, <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND net 3/7] net: hns3: Resolved the issue that the
 debugfs query result is inconsistent.
To: Jakub Kicinski <kuba@kernel.org>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
 <20241107133023.3813095-4-shaojijie@huawei.com>
 <20241111172511.773c71df@kernel.org>
 <e4396ecc-7874-4caf-b25d-870a9d897eb1@huawei.com>
 <20241113163145.04c92662@kernel.org>
 <058dff3c-126a-423a-8608-aa2cebfc13eb@huawei.com>
 <20241209131315.2b0e15bc@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241209131315.2b0e15bc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/10 5:13, Jakub Kicinski wrote:
> On Mon, 9 Dec 2024 22:14:37 +0800 Jijie Shao wrote:
>> Another way is seq_file, which may be a solution,
>> as far as I know, each seq_file has a separate buffer and can be expanded automatically.
>> So it might be possible to solve the problem
>> But even if the solution is feasible, this will require a major refactoring of hns3 debugfs
> seq_file is generally used for text output
>
> can you not hook in the allocation and execution of the cmd into the
> .open handler and freeing in to the .close handler? You already use
> explicit file_ops for this file.


Thank you very much for your advice.

When I modified the code according to your comments,
I found that the problem mentioned in this path can be solved.
I implement .open() and .release() handler for debugfs file_operations，
Move allocation buffer and execution of the cmd to the .open() handler
and freeing in to the .release() handler.
Also allocate separate buffer for each reader and associate the buffer with the file pointer.
In this case, there is no shared buffer, which causes data inconsistency.

However, a new problem is introduced：
If the framework does not call .release() for some reason, the buffer cannot be freed, causing memory leakage.
Maybe it's acceptable？


  static ssize_t hns3_dbg_read(struct file *filp, char __user *buffer,
  			     size_t count, loff_t *ppos)
  {
-	struct hns3_dbg_data *dbg_data = filp->private_data;
+	char *buf = filp->private_data;
+
+	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
+}
+
+static int hns3_dbg_open(struct inode *inode, struct file *filp)
+{
+	struct hns3_dbg_data *dbg_data = inode->i_private;
  	struct hnae3_handle *handle = dbg_data->handle;
  	struct hns3_nic_priv *priv = handle->priv;
-	ssize_t size = 0;
-	char **save_buf;
-	char *read_buf;
  	u32 index;
+	char *buf;
  	int ret;
  
+	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
+	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+		return -EBUSY;
+
  	ret = hns3_dbg_get_cmd_index(dbg_data, &index);
  	if (ret)
  		return ret;
  
-	mutex_lock(&handle->dbgfs_lock);
-	save_buf = &handle->dbgfs_buf[index];
-
-	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state)) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	if (*save_buf) {
-		read_buf = *save_buf;
-	} else {
-		read_buf = kvzalloc(hns3_dbg_cmd[index].buf_len, GFP_KERNEL);
-		if (!read_buf) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		/* save the buffer addr until the last read operation */
-		*save_buf = read_buf;
-
-		/* get data ready for the first time to read */
-		ret = hns3_dbg_read_cmd(dbg_data, hns3_dbg_cmd[index].cmd,
-					read_buf, hns3_dbg_cmd[index].buf_len);
-		if (ret)
-			goto out;
-	}
+	buf = kvzalloc(hns3_dbg_cmd[index].buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
  
-	size = simple_read_from_buffer(buffer, count, ppos, read_buf,
-				       strlen(read_buf));
-	if (size > 0) {
-		mutex_unlock(&handle->dbgfs_lock);
-		return size;
+	ret = hns3_dbg_read_cmd(dbg_data, hns3_dbg_cmd[index].cmd,
+				buf, hns3_dbg_cmd[index].buf_len);
+	if (ret) {
+		kvfree(buf);
+		return ret;
  	}
  
-out:
-	/* free the buffer for the last read operation */
-	if (*save_buf) {
-		kvfree(*save_buf);
-		*save_buf = NULL;
-	}
+	filp->private_data = buf;
+	return 0;
+}
  
-	mutex_unlock(&handle->dbgfs_lock);
-	return ret;
+static int hns3_dbg_release(struct inode *inode, struct file *filp)
+{
+	kvfree(filp->private_data);
+	filp->private_data = NULL;
+	return 0;
  }
  
  static const struct file_operations hns3_dbg_fops = {
  	.owner = THIS_MODULE,
-	.open  = simple_open,
+	.open  = hns3_dbg_open,
  	.read  = hns3_dbg_read,
+	.release = hns3_dbg_release,
  };



